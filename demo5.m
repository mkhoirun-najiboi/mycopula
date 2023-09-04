clear;clc
close all

load stockreturns

x = stocks(:,1:8);

C = nestedfit(x);

