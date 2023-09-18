%% Copula regression 1 predictor
clear;clc
close all
addpath('scr')
load stockreturns

x = stocks(:,2);
y = stocks(:,1);
[yhat,CI] = copreg(x,y,'xpred',x,'ypred',y);
%%
clear;clc
close all
addpath('scr')
load polydata

x = x(:);
y = y(:);
[yhat,CI] = copreg(x,y);
