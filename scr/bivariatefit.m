function C = bivariatefit(x,varargin)

okargs =   {'verbosity'};
defaults = { 1 };
[verbosity] = internal.stats.parseArgs(okargs,defaults,varargin{:});

if size(x,2)~=2
    err = sprintf('The input has %g-variate.',size(x,2));
    error(['Only for bivariate case. ',err,' Please use another method.'])
end

N = size(x,2);
xa = x;

for i = 1:N
    F(1,i) = fitter(xa(:,i),'verbosity',0);
    u(:,i) = cdf(F(i),xa(:,i));
end

c = copfitter(u,'verbosity',0);

if verbosity
    fprintf('Marginal Distribution: \n')
    for i = 1:N
        fprintf(' No. %g:',i)
        fprintf(' Dist Name = %s\n',F(i).DistributionName)
        paramvalue = '';
        for k = 1:length(F(i).ParameterNames)
            paramvalue = [paramvalue,F(i).ParameterNames{k},' = ',num2str(F(i).ParameterValues(k))];
            if k<length(F(i).ParameterNames)
                paramvalue = [paramvalue,', '];
            end
        end
        disp(['             ',paramvalue])
    end
    
    fprintf('\nCase = Bivariate Copula\n')
    disp('Selected by = Akaike Information Criterion')
    disp('Fittest copula:') 
    fprintf(' Copula Name = %s\n',c.copulaName)
    fprintf(' param1 = %.4f\n',c.param1)
    if ~isempty(c.param2)
        fprintf(' param2 = %.4f\n',c.param2)
    end
end

perm = 1:2;
C.perm = perm;
C.Type = 'Bivariate'; 
C.Marginal = F;
C.Copula = c;

L = jointpdf(C,x);
numPar = N-1;
AIC = -2*sum(log(L))+2*numPar;
Pemp = [];
xp = x(:,perm);
n = size(xp,1);
for i = 1:n
    xx = xp(i,:);
    Pemp(i,1) = sum(all(xp<=xx,2));
end
Pemp = (Pemp-0.44)/(n+0.12);

Pthe = jointcdf(C,x);
CvM = sum((Pemp-Pthe).^2);
MSE = sum((Pemp-Pthe).^2)/n;
RMSE = sqrt(MSE);

CvMc = (CvM - 0.4/n + 0.6/n^2) * (1 + 1/n);
% Compute the upper-tail p-value (Stephen, 1970).
pVal = 0.05 * exp(2.79 - 6 * CvMc);
if verbosity
    fprintf('\nGoodness-of-fits:\n AIC (Joint PDF) = %.1f\n CvM  = %.3f\n RMSE = %.3f\n pVal = %.3f\n',...
        AIC,CvM,RMSE,pVal)
end
