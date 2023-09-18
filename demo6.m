%% Nested Copula - Fitting
clear;clc
close all
addpath('scr')
load stockreturns

%% Trivariate
clc
x = stocks(:,1:3);
C = nestedfit(x);

%% Multivariate
clc
x = stocks(:,1:8);
C = nestedfit(x);

%% Joint PDF and CDF
F = jointcdf(C,x);
f = jointpdf(C,x);

%% Nested Copula - Regression - 2 or more predictors
clc
x = stocks(:,2:8);
y = stocks(:,1);
[yhat,CI] = copreg(x,y,'xpred',x,'ypred',y,'method','nested');
