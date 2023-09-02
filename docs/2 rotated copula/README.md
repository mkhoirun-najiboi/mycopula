# ROTATED COPULA
We add counterclockwise rotated copula for Archimedean family.

## What's news?
- add Rotated copula (90, 180, and 270 degrees)
- add other marginal distributions (Gamma, Weibull)
- Hypothesis test for marginal distribution (Anderson-Darling) and copula (Cramer-von Mises)

## What's in here?
This script include 4 marginal continuous univariate distribution and 1 marginal discrete univariate distribution.
- Continuous distributions: GEV, Gamma, Lognormal, Weibull
- Discrete distribution: Negative binomial

and include 9 Archimedean copulas:
- one-parameter: Clayton, Frank, Gumbel, Joe, Galambos copulas
- two-parameter: BB1, BB6, BB7, and BB8 copulas

with counterclockwise rotation.

## Reference
All detail can be seen in my journal article:
- Najib MK, Nurdiati S, Sopaheluwakan A. 2022. Multivariate Fire Risk Models using Copula Regression in Kalimantan Indonesia. Natural Hazard. Early Access. [doi: 10.1007/s11069-022-05346-3](https://doi.org/10.1007/s11069-022-05346-3). [Click here to read online](https://rdcu.be/cLYT8)

## How to use?
#### Get data
Lets get an example with stocks data that provided by MATLAB.
```matlab
clear;clc
load stocks
```
For example, get data as follows.
```matlab
X1 = 5-stocks(:,1);
X2 = stocks(:,2);
```
`X1` and `X2` have a negative correlation
```matlab
corr(X1,X2)
```
```
ans = -0.7228
```
#### Fit Marginal Distribution
Instantly, fitter2 fit all distribution parameter (GEV, GAM, LN, WB) and select the fittest distribution according to Anderson-Darling statistics.
```matlab
F1 = fitter2(X1);
```
```
ans =

  4×4 table

    DistName    ADstat      pval           keputusan
    ________    _______    _______    ____________________

    'GEV'       0.34292    0.90256    "fails to reject h0"
    'GAM'       0.34748    0.89847    "fails to reject h0"
    'LN'        0.57686    0.66971    "fails to reject h0"
    'WB'        0.70449     0.5547    "fails to reject h0"

```
Meanwhile, if the data contains negative value, fitter2 only fit the distribution with real domain (GEV).
```matlab
F2 = fitter2(X2);
```
```
WARNING: Your data contains negative values.
       - The program will only display the results
         of fitting on distributions with real domains.

ans =

  1×4 table

    DistName    ADstat      pval           keputusan
    ________    _______    _______    ____________________

    GEV         0.18004    0.99493    "fails to reject h0"

```
Moreover, if your data is discrete, fitter2 fit the data with negative binomial distribution.

#### Fit copula
After transforming the data according to the fittest marginal distribution, the fittest copula function is selected using `mycopulaCvM`.
```matlab
u1 = cdf(F1,X1);
u2 = cdf(F2,X2);
Cop = mycopulaCvM([u1,u2]);
```
```
Exiting: Maximum number of function evaluations has been exceeded
         - increase MaxFunEvals option.
         Current function value: -34.112316


first_five =

  5×7 table

      famili       param1      param2        CvM       pValue       RMSE        AIC
    ___________    _______    _________    ________    _______    ________    _______

    'BB8-90'       -5.3383    [-0.7318]    0.039715    0.65539    0.019929     -66.65
    'Frank-270'    -6.0224    []           0.062238    0.57177    0.024948    -66.239
    'Frank'        -6.0224    []           0.062238    0.57177    0.024948    -66.239
    'Frank-90'     -6.0224    []           0.062238    0.57177    0.024948    -66.239
    'Frank-180'    -6.0224    []           0.062238    0.57177    0.024948    -66.239

```
You got the 90 degrees rotated BB8 as your copula.
```matlab
mycop = Cop(1)
```
```
mycop =

  struct with fields:

    famili: 'BB8-90'
    param1: -5.3383
    param2: -0.7318
       CvM: 0.0397
    pValue: 0.6554
      RMSE: 0.0199
       AIC: -66.6504
```
You can plot the joint CDFs and joint PDFs as previous example.
#### Joint PDFs
```matlab
x1 = 0:0.01:1;
y1 = 0:0.01:1;
[u1,v1] = meshgrid(x1,y1);
cx = pdfcopula(mycop.famili,[u1(:),v1(:)],mycop.param1,mycop.param2);
cx = reshape(cx,[length(x1),length(y1)]);
cx = cx';
x1 = icdf(F1,u1);f1 = pdf(F1,x1);
x2 = icdf(F2,v1);f2 = pdf(F2,x2);
fx = f1.*f2.*cx;

figure;
contour(x1,x2,fx);colorbar
hold on
scatter(X1,X2)
```
<img src="https://github.com/mkhoirun-najiboi/mycopula/blob/main/docs/2%20rotated%20copula/img/jpdf.jpg" alt="drawing" width="500"/>
