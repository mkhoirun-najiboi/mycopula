%% Fitting Bivariate Copula
clear;clc
close all

%% Add Script Function to the Path
addpath('scr')

%% Load data
load stockreturns

%% Define X1 and X2
x1 = stocks(:,1);
x2 = stocks(:,2);

%% Fitting Marginal Distribution
help fitter

%%
clc
F1 = fitter(x1);
F2 = fitter(x2);

%%
fitter(x1,'verbosity',0,'plotpdf',1);

%% Probability transformation
u1 = cdf(F1,x1);
u2 = cdf(F2,x2);

%% Fitting copula function
C = copfitter([u1,u2],'verbosity',3);

%% One line code
clc
load stockreturns
x = stocks(:,1:2);
C = bivariatefit(x);
