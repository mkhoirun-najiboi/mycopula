%% Symmetric Trivariate - Regression
clear;clc
close all
addpath('scr')

load stockreturns
x = stocks(:,2:3);
y = stocks(:,1);

yhat = copreg(x,y,'xpred',x,'ypred',y,'method','Symmetric');

