function [yhat,CI] = copulareg(x,y,xhat,ytrue,varargin)

okargs =   {'verbosity' 'top' 'npart'};
defaults = {1           0     1000 };
[verbosity,top,npart] = internal.stats.parseArgs(okargs,defaults,varargin{:});

% ============= Fitting Processes ==================%
f = fitter(x,'verbosity',0);
g = fitter(y,'verbosity',0);

u = cdf(f,x);
v = cdf(g,y);

[C,stat] = copfitter([u,v],'verbosity',0); 

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
discrete = all(0 <= ytrue & isfinite(ytrue) & ytrue == round(ytrue)); 
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
xx = xhat;

teks = '';
fprintf('\n')
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
% =============== Result Description ===============%
if verbosity
    fprintf('Response type = %s\n',domain)
    fprintf('Number of training data = %g\n',length(x))
    fprintf('Number of predicting data = %g\n',length(xhat))
    fprintf('Distribution for x = %s\n',f.DistributionName)
    fprintf('Distribution for y = %s\n',g.DistributionName)
    fprintf('Copula = %s\n',C.copulaName)
    
end


% =============== Evaluation Process ===============%
if nargin>3 && ~isempty(ytrue)
    rmse = rms(yhat-ytrue);
    mape = mean(abs((yhat-ytrue)./ytrue));
    wmape = sum(abs(yhat-ytrue))/sum(abs(ytrue));
    fprintf('\nEvaluation Results:\n')
    fprintf('RMSE = %.5g\n',rmse)
    fprintf('MAPE = %.5g\n',mape)
    fprintf('wMAPE = %.5g\n',wmape)
end
    
[~,ii] = sort(xx);
figure()
plot(x,y,'ko')
hold on
plot(xx(ii),yhat(ii),'-r','linewidth',2.7)
plot(xx(ii),CI(ii,1),'-b','linewidth',1.2)
plot(xx(ii),CI(ii,2),'-b','linewidth',1.2)
