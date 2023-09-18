function F = jointcdf(C,x)

x = x(:,C.perm);
switch lower(C.Type)
    case 'fullynested'
        JCDF = evalcopula(C.Copula(1),[cdf(C.Marginal(1),x(:,1)),cdf(C.Marginal(2),x(:,2))],'cdf');
        for i = 2:length(C.Copula)
            JCDF = evalcopula(C.Copula(i),[JCDF,cdf(C.Marginal(i+1),x(:,i+1))],'cdf');
        end
    case 'symmetric'
        JCDF = evalcopula(C.Copula,[cdf(C.Marginal(1),x(:,1)),cdf(C.Marginal(2),x(:,2)),cdf(C.Marginal(3),x(:,3))],'cdf');
    case 'bivariate'
        JCDF = evalcopula(C.Copula,[cdf(C.Marginal(1),x(:,1)),cdf(C.Marginal(2),x(:,2))],'cdf');
end

F = JCDF;