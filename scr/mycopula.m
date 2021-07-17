function [stat] = mycopula(u,sortby)

numVar = size(u,2);

if numVar==2
    % Gaussian
    family = 'Gaussian';
    Rho = copulafit(family,u);
    Cx = @(u) copulacdf('Gaussian',u,Rho);
    cx = @(u) copulapdf('Gaussian',u,Rho);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(1).famili = family;
    stat(1).param1 = Rho(2);
    stat(1).param2 = [];
    stat(1).Dn = Dn;
    stat(1).RMSE = RMSE;
    stat(1).AIC = AIC; 

    % t-Student
    family = 't';
    [Rho,nu] = copulafit(family,u);
    Cx = @(u) copulacdf('t',u,Rho,nu);
    cx = @(u) copulapdf('t',u,Rho,nu);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(2).famili = family;
    stat(2).param1 = Rho(2);
    stat(2).param2 = nu;
    stat(2).Dn = Dn;
    stat(2).RMSE = RMSE;
    stat(2).AIC = AIC; 
    
    % Clayton
    family = 'Clayton';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Clayton',u,param);
    cx = @(u) copulapdf('Clayton',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(3).famili = 'Clayton';
    stat(3).param1 = param;
    stat(3).Dn = Dn;
    stat(3).RMSE = RMSE;
    stat(3).AIC = AIC; 

    % Gumbel
    family = 'Gumbel';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Gumbel',u,param);
    cx = @(u) copulapdf('Gumbel',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(4).famili = 'Gumbel';
    stat(4).param1 = param;
    stat(4).Dn = Dn;
    stat(4).RMSE = RMSE;
    stat(4).AIC = AIC; 

    % Frank
    family = 'Frank';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Frank',u,param);
    cx = @(u) copulapdf('Frank',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(5).famili = 'Frank';
    stat(5).param1 = param;
    stat(5).Dn = Dn;
    stat(5).RMSE = RMSE;
    stat(5).AIC = AIC;

    % Joe
    family = 'Joe';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Joe',u,param);
    cx = @(u) pdfcopula('Joe',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(6).famili = 'Joe';
    stat(6).param1 = param;
    stat(6).Dn = Dn;
    stat(6).RMSE = RMSE;
    stat(6).AIC = AIC; 

    % Galambos
    n = 7;
    family = 'Galambos';
    [param1] = fitcopula(family,u);
    Cx = @(u) cdfcopula('Galambos',u,param1);
    cx = @(u) pdfcopula('Galambos',u,param1);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(n).famili = 'Galambos';
    stat(n).param1 = param1; 
    stat(n).Dn = Dn;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;

    % BB7
    n = 10;
    family = 'BB7';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB7',u,param1,param2); 
    cx = @(u) pdfcopula('BB7',u,param1,param2);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(n).famili = 'BB7';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).Dn = Dn;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;

    % BB8
    n = 11;
    family = 'BB8';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB8',u,param1,param2);
    cx = @(u) pdfcopula('BB8',u,param1,param2);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(n).famili = 'BB8';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).Dn = Dn;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;

    % BB1
    n = 8;
    family = 'BB1';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB1',u,param1,param2);
    cx = @(u) pdfcopula('BB1',u,param1,param2);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(n).famili = 'BB1';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).Dn = Dn;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;

    % BB6
    n = 9;
    family = 'BB6';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB6',u,param1,param2);
    cx = @(u) pdfcopula('BB6',u,param1,param2);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(n).famili = 'BB6';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).Dn = Dn;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
elseif numVar == 3
    % Gaussian
    family = 'Gaussian';
    Rho = copulafit(family,u);
    Cx = @(u) copulacdf('Gaussian',u,Rho);
    cx = @(u) copulapdf('Gaussian',u,Rho);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(1).famili = family;
    stat(1).param1 = Rho;
    stat(1).param2 = [];
    stat(1).Dn = Dn;
    stat(1).RMSE = RMSE;
    stat(1).AIC = AIC; 

    % t-Student
    family = 't';
    [Rho,nu] = copulafit(family,u);
    Cx = @(u) copulacdf('t',u,Rho,nu);
    cx = @(u) copulapdf('t',u,Rho,nu);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(2).famili = family;
    stat(2).param1 = Rho;
    stat(2).param2 = nu;
    stat(2).Dn = Dn;
    stat(2).RMSE = RMSE;
    stat(2).AIC = AIC; 
    
    % Gumbel
    family = 'Gumbel';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Gumbel',u,param);
    cx = @(u) pdfcopula('Gumbel',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(3).famili = 'Gumbel';
    stat(3).param1 = param;
    stat(3).Dn = Dn;
    stat(3).RMSE = RMSE;
    stat(3).AIC = AIC; 
    
    % Clayton
    family = 'Clayton';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Clayton',u,param);
    cx = @(u) pdfcopula('Clayton',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(4).famili = 'Clayton';
    stat(4).param1 = param;
    stat(4).Dn = Dn;
    stat(4).RMSE = RMSE;
    stat(4).AIC = AIC; 
    
    % Frank
    family = 'Frank';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Frank',u,param);
    cx = @(u) pdfcopula('Frank',u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(5).famili = 'Frank';
    stat(5).param1 = param;
    stat(5).Dn = Dn;
    stat(5).RMSE = RMSE;
    stat(5).AIC = AIC;
    
    % Joe
    family = 'Joe';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(6).famili = family;
    stat(6).param1 = param;
    stat(6).Dn = Dn;
    stat(6).RMSE = RMSE;
    stat(6).AIC = AIC; 
      
    % Gumbel Asimetri
    family = 'GumbelAsim';
    [param1,param2,U3] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2,U3);
    cx = @(u) pdfcopula(family,u,param1,param2,U3);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(7).famili = family;
    stat(7).param1 = param1;
    stat(7).param2 = param2;
    stat(7).U3 = U3;
    stat(7).Dn = Dn;
    stat(7).RMSE = RMSE;
    stat(7).AIC = AIC; 
    
    % Clayton Asimetri
    family = 'ClaytonAsim';
    [param1,param2,U3] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2,U3);
    cx = @(u) pdfcopula(family,u,param1,param2,U3);
    numPar = 2;
    [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar);
    stat(8).famili = family;
    stat(8).param1 = param1;
    stat(8).param2 = param2;
    stat(8).U3 = U3;
    stat(8).Dn = Dn;
    stat(8).RMSE = RMSE;
    stat(8).AIC = AIC; 
end
if nargin<2
    [~,ind]=sort([stat.AIC]);
else
    switch lower(sortby)
        case {'dn','kse'}
            [~,ind]=sort([stat.Dn]);
        case {'rmse'}
            [~,ind]=sort([stat.RMSE]);
        case {'aic'}
            [~,ind]=sort([stat.AIC]);
        case {'none'}
            ind = 1:length(stat);
    end
end 
stat=stat(ind);
struct2table(stat)

end
%% Fungsi Pendukung
function [Dn,RMSE,AIC] = copulagof(u,Cx,cx,numPar)
    [n,v] = size(u);
    Pemp = zeros(n,1);
    for i = 1:n
        indeks = [1:n]';
        for k = 1:v
            ind = find(u(:,k)<=u(i,k));
            indeks = intersect(indeks,ind);
        end
        no = length(indeks);
        Pemp(i) = (no-0.44)/(n+0.12);
    end
    Pthe = Cx(u);
    Dn = max(abs(Pemp-Pthe));
    MSE = sum((Pemp-Pthe).^2)/n;
    RMSE = sqrt(MSE);
    L = cx(u);
    AIC = -2*log(prod(L))+2*numPar;
end
