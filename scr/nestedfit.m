function C = nestedfit(x,varargin)

okargs =   {'structplot' 'verbosity'};
defaults = {1            1};
[structplot,verbosity] = internal.stats.parseArgs(okargs,defaults,varargin{:});

N = size(x,2);
xa = x;

for i = 1:N
    F(1,i) = fitter(xa(:,i),'verbosity',0);
    u(:,i) = cdf(F(i),xa(:,i));
end

perm = [];

kor = triu(abs(corr(xa,'type','kendall')),1);
[a,ii] = max(kor);
[~,t] = max(a);
i = ii(t);
perm = [perm,i];

xa(:,[i,t]) = 0;
w = u(:,i); 
teks = 'Fitting Progress: ';
disp(teks) 
for k = 1:N-1 
    fprintf(repmat('\b',1,length(teks)+1))
    teks = sprintf('Fitting Progress: %g/%g',k,N-1);
    disp(teks) 
    perm = [perm,t];
    c(1,k)=copfitter([w,u(:,t)],'verbosity',0);
    if k<N-1
        w = evalcopula(c(k),[w,u(:,t)],'cdf');
        corr(w,xa,'type','kendall');
        [~,t] = max(abs(corr(w,xa,'type','kendall')));
        xa(:,t) = 0;
    end
end
if verbosity
    fprintf(repmat('\b',1,length(teks)+1))
    fprintf('Permutation: %s\n',num2str(perm))
end
F = F(perm);

if verbosity
    fprintf('Marginal Distribution: \n')
    for i = 1:N
        fprintf(' No. %g (x%g):',i,perm(i))
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
    
    fprintf('\nCase = Fully Nested Copula\n')
    disp('Selected by = Akaike Information Criterion')
    disp('Nested Layers:')
    for i = 1:N-1
        fprintf(' No. %g:',i)
        fprintf(' Copula Name = %s\n',c(i).copulaName)

        paramvalue = ['param1 = ',num2str(c(i).param1)];
        if ~isempty(c(i).param2)
            paramvalue = [paramvalue,' param2 = ',num2str(c(i).param2)];
        end
        disp(['        ',paramvalue])
    end
end

C.perm = perm;
C.Type = 'FullyNested'; 
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
    fprintf('Goodness-of-fits:\n AIC (Joint PDF) = %.1f\n CvM  = %.3f\n RMSE = %.3f\n pVal = %.3f\n',...
        AIC,CvM,RMSE,pVal)
end

if structplot
    figure()
    pathx = [0,0,2,2];
    pathy = [1,2,2,1];
    hold on;box on
    plot(pathx,pathy,'k')
    pathx = [0.0,0.0,2,2];
    pathy = [1,2,2,1];
    for i = 2:N-1
        plot(pathx+i-1,pathy+i-1,'k')
    end
    plot([N-1,N-1],[N,N+.5],'k')

    xplot = [0,2:N];
    yplot = [1,1:N-1];
    scatter(xplot,yplot,400,'markerfacecolor','w','markeredgecolor','k')
    xlim([-1,N+1])
    ylim([0,N+1])
    xticks([])
    yticks([])
    text(xplot,yplot,strcat('X',num2str(C.perm')),'horizontal','center','vertical','middle')

    xplot = [1:N-1];
    yplot = [2:N];
    text(xplot,yplot,strcat('C',num2str([1:N-1]')),'horizontal','center','vertical','top')

    title('Nested Structure')
end