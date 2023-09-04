%% Symmetric Trivariate
clear;clc
close all

%% Load data
load stockreturns
X1 = stocks(:,1);
X2 = stocks(:,2);
X3 = stocks(:,3);

%%
F1 = fitter(X1,'verbosity',2); U1 = cdf(F1,X1);
F2 = fitter(X2); U2 = cdf(F2,X2);
F3 = fitter(X3); U3 = cdf(F3,X3);

%%
C = copfitter([U1,U2,U3],'verbosity',3);
