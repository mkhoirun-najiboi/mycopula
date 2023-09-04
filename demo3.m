%% Copula regression 1 predictor
clear;clc
close all
load stockreturns
x = stocks(:,1);
y = stocks(:,2);
[yhat,CI] = copulareg(x,y,'xpred',x,'ypred',y);
%%
clear;clc
close all
load polydata
x = x(:);
y = y(:);
[yhat,CI] = copulareg(x,y);