function f = jointpdf(C,x)

x = x(:,C.perm);
switch lower(C.Type)
    case 'fullynested'
        littleC = evalcopula(C.Copula(1),[cdf(C.Marginal(1),x(:,1)),cdf(C.Marginal(2),x(:,2))],'pdf');
        littleC = littleC.*pdf(C.Marginal(1),x(:,1)).*pdf(C.Marginal(2),x(:,2));
        bigC = evalcopula(C.Copula(1),[cdf(C.Marginal(1),x(:,1)),cdf(C.Marginal(2),x(:,2))],'cdf');
        for i = 2:length(C.Copula)
            littleC = littleC.*evalcopula(C.Copula(i),[bigC,cdf(C.Marginal(i+1),x(:,i+1))],'pdf');
            littleC = littleC.*pdf(C.Marginal(i+1),x(:,i+1));
            bigC = evalcopula(C.Copula(i),[bigC,cdf(C.Marginal(i+1),x(:,i+1))],'cdf');
        end
end

f = littleC;