function [pd,stat] = fitter(data,varargin)
%% ==== fitter ====
% sortby: adstat (default), AIC, kstat
% dist (jika ingin memfit suatu distribusi spesifik): semua (default)
% verbosity: 0 tidak ada keterangan, 1 tampilkan keterangan (default)
% plotpdf: 0 tanpa plot pdf (default), 1 plot pdf
% ================

% varargin
okargs =   {'sortby' 'dist' 'verbosity' 'plotpdf'};
defaults = { 'adstat'   []   1          0     };
[sortby,dist,verbosity,plotpdf] = internal.stats.parseArgs(okargs,defaults,varargin{:});
sortby=lower(sortby);

% check negatifity
negative = any(data<=0);
if negative
    domain = 'Real';
else
    domain = 'Positive';
end
discrete = all(0 <= data & isfinite(data) & data == round(data)); 
if discrete
    domain = 'Discrete';
end

distName = {'ExtremeValue','GeneralizedExtremeValue',...
    'Logistic','Normal','Exponential','Gamma','Inverse Gaussian','Log logistic',...
    'Lognormal','Weibull'};
dname= {'EV','GEV','LOG','NOR','EXP','GAM','ING','LL','LN','WB'};
distName2 = {'Negative Binomial'};
dname2 = {'NBIN'};
decis = {'fails to reject h0','reject h0'};

if ~discrete
% Fitting Distribution with real domains.
for i = 1:4
    warning('');warnMsg=[];warnId=[];
    PDs{i}=fitdist(data,distName{i});
    [warnMsg,~]=lastwarn;
    warning('off')
%     if ~isempty(warnMsg)
%         fprintf(['Warning detected for fitting ',distName{i},'\n'])
%         fprintf(['-- Messege: ',warnMsg,'\n'])
%         st=1;
%     end
    NLL1(i)=negloglik(PDs{i});
end
% Uji
for i = 1:length(PDs)
    D(i).DistName=dname{i};
    [h,p,ad] = adtest(data,'Distribution',PDs{i});
    [~,pval,ks] = kstest(data,'cdf',PDs{i});
    D(i).KSstat = ks;
    D(i).KSpval = pval;
    D(i).ADstat = ad;
    D(i).ADpval = p;
    D(i).AIC = aicbic(-NLL1(i),length(PDs{i}.Params));
    D(i).Decision = decis{h+1};
    %     D1(i).NLogL=NLL1(i);
end

if ~negative
    for i = 5:10
        % Fitting Distribution with positive domains.for i = 1:length(distName)
        warning('');warnMsg=[];warnId=[];
        PDs{i}=fitdist(data,distName{i});
        [warnMsg,~]=lastwarn;
        warning('off')
%         if ~isempty(warnMsg)
%             fprintf(['Warning detected for fitting ',distName{i},'\n'])
%             st=1;
%         end
        NLL1(i)=negloglik(PDs{i});
    end
    % Uji
    for i = 1:length(PDs)
        D(i).DistName=dname{i};
        [h,p,ad] = adtest(data,'Distribution',PDs{i});
        [~,pval,ks] = kstest(data,'cdf',PDs{i});
        D(i).KSstat = ks;
        D(i).KSpval = pval;
        D(i).ADstat = ad;
        D(i).ADpval = p;
        D(i).AIC = aicbic(-NLL1(i),length(PDs{i}.Params));
        D(i).Decision = decis{h+1};
        %     D1(i).NLogL=NLL1(i);
    end
end
else
    i = 1;
    warning('');warnMsg=[];warnId=[];
    PDs{i}=fitdist(data,distName2{i});
    [warnMsg,~]=lastwarn;
    warning('off')
%     if ~isempty(warnMsg)
%         fprintf(['Warning detected for fitting ',distName2{i},'\n'])
%         st=1;
%     end
    NLL1(i)=negloglik(PDs{i}); 
    % Uji 
    D(i).DistName=dname2{i};
    [h,p,ad] = adtest(data,'Distribution',PDs{i});
    D(i).ADstat = ad;
    D(i).ADpval = p;
    D(i).AIC = aicbic(-NLL1(i),length(PDs{i}.Params));
    D(i).Decision = decis{h+1};
    %     D1(i).NLogL=NLL1(i);
end

if ~isempty(dist)
    [~,rind] = ismember(dist,dname);
    PDs=PDs(rind);D=D(rind);
end

% Sorting Distribution
indx1=1:length(D);
[~,sortin]=ismember(sortby,{'adstat','pval','aic','nosort','ksstat'});
if sortin == 1
    [~,indx1]=sort([D.ADstat]);
    sortname = 'Anderson-Darling Stastistics';
elseif sortin == 2
    [~,indx1]=sort([D.pval],'descend');
    sortname = 'Anderson-Darling p-value';
elseif sortin == 3
    [~,indx1]=sort([D.AIC]); 
    sortname = 'Akaike Information Criterion';
elseif sortin == 4
    indx1=1:length(D);
    sortname = 'No sort';
elseif sortin == 5
    indx1=1:length(D);
    sortname = 'Kolmogorov-Smirnov Stastistics';
else
    error('Input Argument:Sortby')
end
% Sort
D=D(indx1); PD = PDs(indx1);
D=D';PD=PD';
% if sortin~=3
%     D = rmfield(D, 'AIC');
% end
pd = PD{1};
stat = D(1);

if verbosity
    disp(['Domain = ',domain])
    disp(['Sort by = ',sortname]) 
    disp(['fittest distribution = ',pd.DistributionName])
    paramvalue = '';
    for i = 1:length(pd.ParameterNames)
        paramvalue = [paramvalue,pd.ParameterNames{i},' = ',num2str(pd.ParameterValues(i))];
        if i<length(pd.ParameterNames)
            paramvalue = [paramvalue,', '];
        end
    end
    disp(['Parameters: ',paramvalue])
    fprintf('Decision: %s (AD pval=%.4f)\n',D(1).Decision,D(1).ADpval)
    if verbosity>1
        disp(['Summary = '])
        disp(' ')
        disp(struct2table(D))
    else
        disp(' ')
    end
end

if plotpdf
    figure()
    hh = histogram(data,'Normalization','pdf');
    xfig = linspace(hh.BinLimits(1),hh.BinLimits(2),100);
    hold on 
    plot(xfig,pdf(pd,xfig),'linewidth',1.2)
    legend('Empirical','Theoretical')
    xlabel('x')
    ylabel('pdf')
end

