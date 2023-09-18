function [yhat,CI] = copreg(x,y,varargin)

okargs =   {'verbosity' 'npart' 'xpred' 'ypred' 'method'};
defaults = {1            1000     []      []    'nested'};
[verbosity,npart,xpred,ypred,method] = internal.stats.parseArgs(okargs,defaults,varargin{:});

if size(x,2)<2
    fprintf('Case: %g-predictor\n',size(x,2))
    fprintf('Method: Bivariate copula\n')
    [yhat,CI] = reg1(x,y,'verbosity',verbosity,...
        'npart',npart,'xpred',xpred,'ypred',ypred);
    return
end

predicts = 1;
if isempty(xpred)
    for i = 1:size(x,2)
        xpred(:,i) = linspace(min(x(:,i)),max(x(:,i)),100);
    end
    predicts = 0;
end

switch lower(method)
    case 'symmetric'
        if size(x,2)~=2
            err = sprintf('The input has %g predictors.',size(x,2));
            error(['Only for 2 predictors case. ',err,' Please use another method.'])
        end
        disp('Fit copula (X,Y)')
        Ctop = symmetricfit([x,y],'verbosity',0);
        disp('Fit copula (X)')
        Cbot = bivariatefit(x,'verbosity',0); 
    case 'nested'
        disp('Fit copula (X,Y)')
        Ctop = nestedfit([x,y],'verbosity',0,'structplot',0);
        disp('Fit copula (X)')
        Cbot = nestedfit(x,'verbosity',0,'structplot',0);
end

fcond = @(x,y) jointpdf(Ctop,[x,y])./jointpdf(Cbot,x);

% check negatifity and continuity =====
discrete = all(0 <= y & isfinite(y) & y == round(y)); 
if discrete
    domain = 'Discrete';
else
    domain = 'Continuous';
end

% start regression =====
g = fitter(y,'verbosity',0);
if discrete
    yy = 0:icdf(g,0.9999);
else
    yy = linspace(icdf(g,0.0001),icdf(g,0.9999),npart);
end
xx = xpred;

fprintf('Case: %g-predictor\n',size(x,2))
fprintf('Method: %s\n',method)

teks = '';
fprintf('\n')
for k = 1:length(xx)
    xp = repmat(xx(k,:),length(yy),1);
    yp = yy(:);
    cond_prob = fcond(xp,yp);
    expected = sum(cond_prob(1:end-1).*yy(2:end)'.*diff(yy)');
    cond_dist = cumsum(cond_prob)*1/max(cumsum(cond_prob));
    upper_bnd = yy(find(cond_dist>=0.975,1,'first'));
    lower_bnd = yy(find(cond_dist>=0.025,1,'first'));
    if isempty(upper_bnd);upper_bnd=NaN;end
    if isempty(lower_bnd);lower_bnd=NaN;end
    yhat(k,:) = expected;
    CI(k,:) = [lower_bnd,upper_bnd];
    fprintf(repmat('\b',1,length(teks)+1))
    teks = sprintf('Regression Progress: %.2f%%',k*100/length(xx));
    disp(teks)
end


% =============== Evaluation Process ===============%
fprintf('Data length for fitting = %g\n',length(x))
if predicts
    fprintf('Data length for predicting = %g\n',length(xpred))
end
if ~isempty(ypred)
    rmse = rms(yhat-ypred);
    mape = mean(abs((yhat-ypred)./ypred));
    wmape = sum(abs(yhat-ypred))/sum(abs(ypred));
    fprintf('Evaluation Results:\n')
    fprintf('RMSE = %.5g\n',rmse)
    fprintf('MAPE = %.5g\n',mape)
    fprintf('wMAPE = %.5g\n',wmape)
end

if ~predicts
    yhat = [];
    CI = [];
end

% [~,ii] = sort(xx);
% figure()
% hold on; box on
% plot(x,y,'ko')
% plot(xx(ii),yhat(ii),'-r','linewidth',2.7)
% plot(xx(ii),CI(ii,1),'-b','linewidth',1.2)
% plot(xx(ii),CI(ii,2),'-b','linewidth',1.2)
% xlabel('X')
% ylabel('Y')
