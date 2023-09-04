clear;clc
close all

load stockreturns

x = stocks(:,1:8);

C = nestedfit(x)

% Permutation: 2  1  8  5  6  7  3  4


