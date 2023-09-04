function [C,stat] = copfitter(u,varargin)

numVar = size(u,2);

okargs =   {'sortby' 'verbosity' 'onlynongaussian'};
defaults = { 'aic'    1          0                };
[sortby,verbosity,onlynongaussian] = internal.stats.parseArgs(okargs,defaults,varargin{:});

if numVar==2
    Case = 'Bivariate';
    % Gaussian
    family = 'Gaussian';
    Rho = copulafit(family,u);
    Cx = @(u) copulacdf('Gaussian',u,Rho);
    cx = @(u) copulapdf('Gaussian',u,Rho);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(1).copulaName = family;
    stat(1).param1 = Rho(2);
    stat(1).param2 = [];
    stat(1).CvM = CvM;
    stat(1).pValue = pValue;
    stat(1).RMSE = RMSE;
    stat(1).AIC = AIC;
    
    % t-Student
    family = 't';
    [Rho,nu] = copulafit(family,u);
    Cx = @(u) copulacdf('t',u,Rho,nu);
    cx = @(u) copulapdf('t',u,Rho,nu);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(2).copulaName = family;
    stat(2).param1 = Rho(2);
    stat(2).param2 = nu;
    stat(2).CvM = CvM;
    stat(2).pValue = pValue;
    stat(2).RMSE = RMSE;
    stat(2).AIC = AIC;
    
    % Clayton
    family = 'Clayton';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Clayton',u,param);
    cx = @(u) copulapdf('Clayton',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(3).copulaName = 'Clayton';
    stat(3).param1 = param;
    stat(3).param2 = [];
    stat(3).CvM = CvM;
    stat(3).pValue = pValue;
    stat(3).RMSE = RMSE;
    stat(3).AIC = AIC;
    
    n = 14;
    family = 'Clayton-90';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 15;
    family = 'Clayton-180';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 16;
    family = 'Clayton-270';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % Gumbel
    family = 'Gumbel';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Gumbel',u,param);
    cx = @(u) copulapdf('Gumbel',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(4).copulaName = 'Gumbel';
    stat(4).param1 = param;
    stat(4).CvM = CvM;
    stat(4).pValue = pValue;
    stat(4).RMSE = RMSE;
    stat(4).AIC = AIC;
    
    n = 17;
    family = 'Gumbel-90';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 18;
    family = 'Gumbel-180';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 19;
    family = 'Gumbel-270';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % Frank
    family = 'Frank';
    param = copulafit(family,u);
    Cx = @(u) copulacdf('Frank',u,param);
    cx = @(u) copulapdf('Frank',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(5).copulaName = 'Frank';
    stat(5).param1 = param;
    stat(5).CvM = CvM;
    stat(5).pValue = pValue;
    stat(5).RMSE = RMSE;
    stat(5).AIC = AIC;
    
    % Joe
    family = 'Joe';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Joe',u,param);
    cx = @(u) pdfcopula('Joe',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(6).copulaName = 'Joe';
    stat(6).param1 = param;
    stat(6).CvM = CvM;
    stat(6).pValue = pValue;
    stat(6).RMSE = RMSE;
    stat(6).AIC = AIC;
    
    % Joe
    n = 12;
    family = 'Joe-90';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    
    % Joe
    n = 13;
    family = 'Joe-180';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % Joe
    n = 14;
    family = 'Joe-270';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % Galambos
    n = 7;
    family = 'Galambos';
    [param1] = fitcopula(family,u);
    Cx = @(u) cdfcopula('Galambos',u,param1);
    cx = @(u) pdfcopula('Galambos',u,param1);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = 'Galambos';
    stat(n).param1 = param1;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 23;
    family = 'Galambos-90';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 24;
    family = 'Galambos-180';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 25;
    family = 'Galambos-270';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % BB7
    n = 10;
    family = 'BB7';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB7',u,param1,param2);
    cx = @(u) pdfcopula('BB7',u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = 'BB7';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 26;
    family = 'BB7-90';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 27;
    family = 'BB7-180';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 28;
    family = 'BB7-270';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % BB8
    n = 11;
    family = 'BB8';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB8',u,param1,param2);
    cx = @(u) pdfcopula('BB8',u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = 'BB8';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 21;
    family = 'BB8-90';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 22;
    family = 'BB8-180';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 29;
    family = 'BB8-270';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % BB1
    n = 8;
    family = 'BB1';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB1',u,param1,param2);
    cx = @(u) pdfcopula('BB1',u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = 'BB1';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 30;
    family = 'BB1-90';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 31;
    family = 'BB1-180';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 32;
    family = 'BB1-270';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    % BB6
    n = 9;
    family = 'BB6';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula('BB6',u,param1,param2);
    cx = @(u) pdfcopula('BB6',u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = 'BB6';
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 33;
    family = 'BB6-90';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 34;
    family = 'BB6-180';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
    n = 20;
    family = 'BB6-270';
    [param1,param2] = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param1,param2);
    cx = @(u) pdfcopula(family,u,param1,param2);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(n).copulaName = family;
    stat(n).param1 = param1;
    stat(n).param2 = param2;
    stat(n).CvM = CvM;
    stat(n).pValue = pValue;
    stat(n).RMSE = RMSE;
    stat(n).AIC = AIC;
    
elseif numVar==3
    Case = 'Symmetric Trivariate';
    % Gaussian
    family = 'Gaussian';
    Rho = copulafit(family,u);
    Cx = @(u) copulacdf('Gaussian',u,Rho);
    cx = @(u) copulapdf('Gaussian',u,Rho);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(1).copulaName = family;
    stat(1).param1 = Rho;
    stat(1).param2 = [];
    stat(1).CvM = CvM;
    stat(1).pValue = pValue;
    stat(1).RMSE = RMSE;
    stat(1).AIC = AIC;
    
    % t-Student
    family = 't';
    [Rho,nu] = copulafit(family,u);
    Cx = @(u) copulacdf('t',u,Rho,nu);
    cx = @(u) copulapdf('t',u,Rho,nu);
    numPar = 2;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(2).copulaName = family;
    stat(2).param1 = Rho;
    stat(2).param2 = nu;
    stat(2).CvM = CvM;
    stat(2).pValue = pValue;
    stat(2).RMSE = RMSE;
    stat(2).AIC = AIC;
    
    % Gumbel
    family = 'Gumbel';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Gumbel',u,param);
    cx = @(u) pdfcopula('Gumbel',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(3).copulaName = 'Gumbel';
    stat(3).param1 = param;
    stat(3).CvM = CvM;
    stat(3).pValue = pValue;
    stat(3).RMSE = RMSE;
    stat(3).AIC = AIC;
    
    % Clayton
    family = 'Clayton';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Clayton',u,param);
    cx = @(u) pdfcopula('Clayton',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(4).copulaName = 'Clayton';
    stat(4).param1 = param;
    stat(4).CvM = CvM;
    stat(4).pValue = pValue;
    stat(4).RMSE = RMSE;
    stat(4).AIC = AIC;
    
    % Frank
    family = 'Frank';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula('Frank',u,param);
    cx = @(u) pdfcopula('Frank',u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(5).copulaName = 'Frank';
    stat(5).param1 = param;
    stat(5).CvM = CvM;
    stat(5).pValue = pValue;
    stat(5).RMSE = RMSE;
    stat(5).AIC = AIC;
    
    % Joe
    family = 'Joe';
    param = fitcopula(family,u);
    Cx = @(u) cdfcopula(family,u,param);
    cx = @(u) pdfcopula(family,u,param);
    numPar = 1;
    [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar);
    stat(6).copulaName = family;
    stat(6).param1 = param;
    stat(6).CvM = CvM;
    stat(6).pValue = pValue;
    stat(6).RMSE = RMSE;
    stat(6).AIC = AIC;
end

if onlynongaussian
    stat(1:2)=[];
end

switch lower(sortby)
    case {'cvm'}
        [~,ind]=sort([stat.CvM]);
        sortname = 'Cramer-von Mises Statistics';
    case {'rmse'}
        [~,ind]=sort([stat.RMSE]);
        sortname = 'Root Mean Squared Error';
    case {'aic'}
        [~,ind]=sort([stat.AIC]);
        sortname = 'Akaike Information Criterion';
    case {'none'}
        ind = 1:length(stat);
        sortname = 'No sorting';
end

stat=stat(ind);
C = stat(1);

if verbosity
    disp(['Case = ',Case])
    disp(['Sort by = ',sortname])
    disp(['Fittest copula = ',C.copulaName])
    if numVar==2
        paramvalue = ['param1 = ',num2str(C.param1)];
        if ~isempty(C.param2)
            paramvalue = [paramvalue,' param2 = ',num2str(C.param2)];
        end
        disp(['Parameter(s): ',paramvalue])
    elseif numVar==3
        disp(['Parameter: param1 = '])
        display(C.param1)
        if ~isempty(C.param2)
            disp(['          param2 = ',num2str(C.param2)])
        end
    end
    dec = 'fails to reject h0';
    if C.pValue<0.5;dec = 'reject h0';end
    fprintf('Decision: %s (CvM pval=%.4f)\n',dec,C.pValue)
    if verbosity>2
        disp('Summary = ')
        disp(' ')
        summary = struct2table(stat);
        disp(summary)
    elseif verbosity>1
        disp('Top 5 copula = ')
        disp(' ')
        first_five = struct2table(stat(1:5));
        disp(first_five)
    else
        fprintf('\n')
    end
end

end
%% Fungsi Pendukung
function [CvM,RMSE,AIC,pValue] = copulagof(u,Cx,cx,numPar)
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

CvM = sum((Pemp-Pthe).^2);
MSE = sum((Pemp-Pthe).^2)/n;
RMSE = sqrt(MSE);
L = cx(u);
AIC = -2*log(prod(L))+2*numPar;
pValue = CvMpValue(CvM,n);
end

function cm = CvMpValue(z,n)
% Evaluate the Cramer-von Mises asymptotic p-value.
% Transform the CvM statistic using Stephens (1970) approximation
% for known F(x).
z = (z - 0.4/n + 0.6/n^2) * (1 + 1/n);
% Compute the upper-tail p-value (Stephen, 1970).
cm = 0.05 * exp(2.79 - 6 * z);
end
