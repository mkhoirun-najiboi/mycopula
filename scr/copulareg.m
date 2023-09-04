function [yhat,CI] = copulareg(x,y,varargin)

okargs =   {'verbosity' 'top' 'npart' 'xpred' 'ypred'};
defaults = {1           0     1000     []      []};
[verbosity,top,npart,xpred,ypred] = internal.stats.parseArgs(okargs,defaults,varargin{:});

predicts = 1;
if isempty(xpred)
    xpred = linspace(min(x),max(x),100);
    predicts = 0;
end

% ============= Fitting Processes ==================%
disp('Marginal: X')
f = fitter(x,'verbosity',1);
disp('Marginal: Y')
g = fitter(y,'verbosity',1);

u = cdf(f,x);
v = cdf(g,y);

[C,stat] = copfitter([u,v],'verbosity',1); 

if top
    C = stat(top);
end


% =============== Regression Process ===============%
if isempty(C.param2)
    c = @(u) pdfcopula(C.copulaName,u,C.param1);
else
    c = @(u) pdfcopula(C.copulaName,u,C.param1,C.param2);
end 

% check negatifity and continuity =====
discrete = all(0 <= y & isfinite(y) & y == round(y)); 
if discrete
    domain = 'Discrete';
else
    domain = 'Continuous';
end

% start regression =====
if discrete
    yy = 0:icdf(g,0.9999);
else
    yy = linspace(icdf(g,0.0001),icdf(g,0.9999),npart);
end
xx = xpred;

teks = '';
fprintf('\n\n')
for k = 1:length(xx)
    u = [cdf(f,repmat(xx(k),length(yy),1)),cdf(g,yy(:))];
    cond_prob = c(u).*pdf(g,yy)';
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
%% 

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

[~,ii] = sort(xx);
figure()
hold on
plot(x,y,'ko')
plot(xx(ii),yhat(ii),'-r','linewidth',2.7)
plot(xx(ii),CI(ii,1),'-b','linewidth',1.2)
plot(xx(ii),CI(ii,2),'-b','linewidth',1.2)
xlabel('X')
ylabel('Y')
