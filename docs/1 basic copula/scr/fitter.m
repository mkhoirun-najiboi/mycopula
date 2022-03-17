function [pd,stat] = fitter(data,pdname)
distname = {'gev','lognormal','poisson','nbin'};
if nargin<2
    stat = [];
    stat.AIC = 99999;
    pd = [];
    for i = 1:2
        try
            [pd1,stat1] = fitter(data,distname{i});
        catch
            continue
        end
        if stat1.AIC<stat.AIC
            pd=pd1;
            stat=stat1;
        end
    end
    return
else
    pdname = internal.stats.getParamVal(pdname,distname,'FAMILY'); 
end
switch pdname
    case 'gev'
        pd = fitdist(data,pdname);
        [h,p,ad] = adtest(data,'Distribution',pd); 
        stat.distribusi = pdname;
        stat.keputusan = h;
        stat.pval = p;
        stat.ADstat = ad;
        stat.k = pd.k;
        stat.sigma = pd.sigma;
        stat.mu = pd.mu;
        stat.NLogL = gevlike(pd.Params,data);
        stat.AIC = aicbic(-stat.NLogL,3);
    case 'lognormal'
        pd = fitdist(data,pdname);
        [h,p,ad] = adtest(data,'Distribution',pd); 
        stat.distribusi = pdname;
        stat.keputusan = h;
        stat.pval = p;
        stat.ADstat = ad; 
        stat.sigma = pd.sigma;
        stat.mu = pd.mu;
        stat.NLogL = lognlike(pd.Params,data);
        stat.AIC = aicbic(-stat.NLogL,2);
    case 'nbin'
        pd = fitdist(data,'nbin');  
        stat.distribusi = 'binomial negatif'; 
        stat.R = pd.R;
        stat.P = pd.P; 
        stat.NLogL = nbinlike(pd.Params,data);
        stat.AIC = aicbic(-stat.NLogL,2);
    case 'poisson'
        pd = fitdist(data,'poisson');  
        stat.distribusi = 'poisson'; 
        stat.param = pd.Params; 
        stat.NLogL = pd.NLogL;
        stat.AIC = aicbic(-stat.NLogL,1);
end

        