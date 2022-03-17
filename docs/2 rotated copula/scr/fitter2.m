function [pd,stat] = fitter2(data,varargin)
% varargin
okargs =   {'sortby' 'dist' 'statshow'};
defaults = {'adstat'   []        1    };
[sortby,dist,statshow] = internal.stats.parseArgs(okargs,defaults,varargin{:});
sortby=lower(sortby);

% check negatifity
discrete = all(0 <= data & isfinite(data) & data == round(data)); 
if discrete
disp('WARNING: Your data is discrete.')
disp('       - The program will only display the results of fitting')
disp('         on discrete distributions, i.e. negative binomial.')
end

distName = {'GeneralizedExtremeValue','Gamma','Lognormal','Weibull'};
distName2 = {'Negative Binomial'};
dname = {'GEV','GAM','LN','WB'};
dname2 = {'NBIN'};
decis = {"fails to reject h0","reject h0"};

if ~discrete
    for i = 1:4
        warning('');warnMsg=[];warnId=[];
        PDs{i}=fitdist(data,distName{i});
        [warnMsg,~]=lastwarn;
        warning('off')
        if ~isempty(warnMsg)
            fprintf(['Warning detected for fitting ',distName{i},'\n'])
            fprintf(['-- Messege: ',warnMsg,'\n'])
            st=1;
        end
        NLL1(i)=negloglik(PDs{i});
    end
    % Uji
    for i = 1:length(PDs)
        D(i).DistName=dname{i};
        [h,p,ad] = adtest(data,'Distribution',PDs{i});
        D(i).ADstat = ad;
        D(i).pval = p;
        D(i).keputusan = decis{h+1};
        %     D1(i).NLogL=NLL1(i);
        D(i).AIC = aicbic(-NLL1(i),length(PDs{i}.Params));
    end
end

if discrete
    i = 1;
    warning('');warnMsg=[];warnId=[];
    PDs{i}=fitdist(data,distName2{i});
    [warnMsg,~]=lastwarn;
    warning('off')
    if ~isempty(warnMsg)
        fprintf(['Warning detected for fitting ',distName2{i},'\n'])
        st=1;
    end
    NLL1(i)=negloglik(PDs{i}); 
    % Uji 
    D(i).DistName=dname2{i};
    [h,p,ad] = adtest(data,'Distribution',PDs{i});
    D(i).ADstat = ad;
    D(i).pval = p;
    D(i).keputusan = decis{h+1};
    %     D1(i).NLogL=NLL1(i);
    D(i).AIC = aicbic(-NLL1(i),length(PDs{i}.Params));
end

if ~isempty(dist)
    [~,rind] = ismember(dist,dname);
    PDs=PDs(rind);D=D(rind);
end

% Sorting Distribution
indx1=1:length(D);
[~,sortin]=ismember(sortby,{'adstat','pval','aic','nosort'});
if sortin == 1
    [~,indx1]=sort([D.ADstat]); 
elseif sortin == 2
    [~,indx1]=sort([D.pval],'descend');
elseif sortin == 3
    [~,indx1]=sort([D.AIC]); 
elseif sortin == 4
    indx1=1:length(D);
else
    error('Marginal Distribution Fitter: Input Argument: Sortby')
end
% Sort
D=D(indx1); PD = PDs(indx1);
D=D';PD=PD';
if sortin~=3
    D = rmfield(D, 'AIC');
end
pd = PD{1};
stat = D(1);

if statshow
    struct2table(D)
end