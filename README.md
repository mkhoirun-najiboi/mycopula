# mycopula
A MATLAB script to built a copula-based joint distribution for bivariate and trivariate cases.

## Hello there !
This is an example, how to use this package code to build a copula-based joint distribution function. You can download all code above and open ```Examples.mlx``` in MATLAB.
I used 11 bivariate and 8 trivariate different copula as mentioned in

Preprints: [Najib_STACLIM2021.pdf](https://github.com/mkhoirun-najiboi/mycopula/blob/main/paper/Najib_STACLIM2021.pdf)

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
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig1.png" alt="drawing" width="500"/>

## Fit the univariate marginal distributions of each data
I used three marginal distributions, i.e., Generalized Extreme Value and Lognormal Distribution for continous data, and Negative Binomial Distribution for discrete data.
```javascript
[Fx,statx] = fitter(x,'gev')
```
```
Fx = 

  GeneralizedExtremeValueDistribution

  Generalized Extreme Value distribution
        k = -0.328924   [-0.432335, -0.225513]
    sigma =   1.07646   [0.930162, 1.24577]
       mu = -0.549162   [-0.77785, -0.320473]


statx = 

  struct with fields:

    distribusi: 'gev'
     keputusan: 0
          pval: 0.9042
        ADstat: 0.3411
             k: -0.3289
         sigma: 1.0765
            mu: -0.5492
         NLogL: 145.5971
           AIC: 297.1942
```
```javascript
[Fy,staty] = fitter(y,'gev')
```
```
Fy = 

  GeneralizedExtremeValueDistribution

  Generalized Extreme Value distribution
        k = -0.213617   [-0.350629, -0.0766055]
    sigma =   1.19747   [1.02513, 1.39878]
       mu = -0.668376   [-0.930156, -0.406596]


staty = 

  struct with fields:

    distribusi: 'gev'
     keputusan: 0
          pval: 0.9949
        ADstat: 0.1800
             k: -0.2136
         sigma: 1.1975
            mu: -0.6684
         NLogL: 163.9329
           AIC: 333.8659
```
Now, you have got the marginal distribution of your data. "keputusan" is 0 meaning that there is no reason to reject the fitted distribution, based on the Anderson-Darling test with 5% alpha.

## Transform your data
Transform your data to uniform~(0,1) using fitted marginal distribution.
```javascript
u = cdf(Fx,x);
v = cdf(Fy,y);
scatterhist(u,v)
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig2.png" alt="drawing" width="500"/>

## Get your fittest copula
```javascript
stat = mycopula([u,v]);
```

  famili    |  param1    |    param2       |   Dn     |    RMSE    |    AIC  
------------ | ------------- | ------------- | ------------- | ------------- | -------------
'Gaussian' |   0.72065   | []           |   0.054113  |  0.020917  |  -71.239
't'        |   0.72057  |  [1.3590e+07] |   0.054122  |   0.02092  |  -69.239
'BB8'      |    5.2154 |   [    0.7448] |   0.046991  |  0.017162  |  -66.681
'Frank'    |    6.0292 |   []           |   0.057931  |   0.02152  |  -65.961
'Galambos' |     1.195 |   []           |   0.048434  |  0.019472  |  -65.558
'Gumbel'   |    1.9136 |   []           |   0.048723  |  0.019405  |  -65.307
'BB1'      |   0.18977 |   [    1.7648] |   0.051983  |  0.020486  |   -64.65
'BB6'      |         1 |   [    1.9136] |   0.048723  |  0.019405  |  -63.307
'BB7'      |    1.9456 |   [    0.6175] |   0.057222  |  0.023555  |  -60.891
'Joe'      |    2.2048 |   []           |   0.052799  |  0.026767  |  -52.821
'Clayton'   |   1.1001 |   []           |    0.10383  |  0.041419  |  -41.987

## Plot your copula distribution
For 1-parameter copula:
```javascript
x1 = 0:0.1:1;
y1 = 0:0.1:1;
[u1,v1] = meshgrid(x1,y1); 
Cx = cdfcopula('Gaussian',[u1(:),v1(:)],0.7206);
Cx = reshape(Cx,[length(x1),length(y1)]);
Cx = Cx';

contour(x1,y1,Cx);colorbar
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig3.png" alt="drawing" width="500"/>

For 2-parameter copula:
```javascript
x1 = 0:0.1:1;
y1 = 0:0.1:1;
[u1,v1] = meshgrid(x1,y1); 
Cx = cdfcopula('BB8',[u1(:),v1(:)],5.2154,0.7448);
Cx = reshape(Cx,[length(x1),length(y1)]);
Cx = Cx';

contour(x1,y1,Cx);colorbar;
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig4.png" alt="drawing" width="500"/>

## Plot your copula density with transformed data
```javascript
For 1-parameter copula:
x1 = 0:0.1:1;
y1 = 0:0.1:1;
[u1,v1] = meshgrid(x1,y1); 
cx = pdfcopula('Gaussian',[u1(:),v1(:)],0.7206);
cx = reshape(cx,[length(x1),length(y1)]);
cx = cx';

figure;
contour(x1,y1,cx);colorbar
hold on 
scatter(u,v)
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig5.png" alt="drawing" width="500"/>

## Plot your copula density with actual data
```javascript
For 1-parameter copula:
x1 = 0:0.01:1;
y1 = 0:0.01:1;
[u1,v1] = meshgrid(x1,y1); 
cx = pdfcopula('Gaussian',[u1(:),v1(:)],0.7206);
cx = reshape(cx,[length(x1),length(y1)]);
cx = cx';
x1 = icdf(Fx,u1);f1 = pdf(Fx,x1);
x2 = icdf(Fy,v1);f2 = pdf(Fy,x2);
fx = f1.*f2.*cx;

figure;
contour(x1,x2,fx);colorbar
hold on 
scatter(x,y)
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/img/Fig6.png" alt="drawing" width="500"/>
