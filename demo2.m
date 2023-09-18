%% Joint Probability Density Function and Its Visualization
clear;clc
close all
addpath('scr')

%% Joint CDF and PDF
load stockreturns
x = stocks(:,1:2);
C = bivariatefit(x,'verbosity',0);
jcdf = jointcdf(C,x);
jpdf = jointpdf(C,x);

%% Visualization (only contour of joint PDF)
figure()
x = stocks(:,1:2);
biplot(x);

%% Visualization (with data)
figure()
x = stocks(:,1:2);
biplot(x,'showdata',1,'showtext','off');

