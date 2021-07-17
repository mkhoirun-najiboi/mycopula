# mycopula
A MATLAB script to built a copula-based joint distribution for bivariate and trivariate cases.

## Hello there !
This is an example, how to use this package code to build a copula-based joint distribution function. You can download all code above and open ```Examples.mlx``` in MATLAB.
I used 11 bivariate and 8 trivariate different copula as mentioned in

Preprints: https://github.com/mkhoirun-najiboi/mycopula/blob/main/paper/Najib_STACLIM2021.pdf

and a coming soon article. I suggest you to read the article before using this code, in order to understand what is in this code.
If you use this code for your work, please cite this web page and our work above.

https://github.com/mkhoirun-najiboi/mycopula

and

[Najib MK et al., (2021) Quantifying the Joint Distribution of Drought Indicators in Borneo Fire-Prone Area. In: The 4th International Conference on Science & Technology Applications in Climate Change.](https://github.com/mkhoirun-najiboi/mycopula/blob/main/paper/Najib_STACLIM2021.pdf)

Let's Start !!

## First of all, get your data. 
In this example, I use the data contained in matlab, i.e., the stock returns dataset.

```javascript
clear;clc
addpath('scr\')

load stockreturns.mat
x = stocks(:,1);
y = stocks(:,2);
```
## Plot your data

```javascript
figure;
scatterhist(x,y)
```
![Fig 1](https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig1.eps)
