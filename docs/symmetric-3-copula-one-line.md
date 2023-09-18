# Symmetric 3-Copula (One-line step)

Here is a more convenient way to fit trivariate copulas symmetrically.

## Fitting Process

**Load Data**\
Arrange the data so that it becomes a matrix whose columns are each variable.
```matlab
load stockreturns
x = stocks(:,1:3);
```

**Fit the Copula**\
Just like bivariate copula, the fitting step begins by determining the marginal distribution, then transforming the data.

```matlab
C = symmetricfit(x);
```

```text
% ===== OUTPUT ======
Marginal Distribution: 
 No. 1: Dist Name = Logistic
             mu = -0.19364, sigma = 0.58158
 No. 2: Dist Name = Generalized Extreme Value
             k = -0.21362, sigma = 1.1975, mu = -0.66838
 No. 3: Dist Name = Generalized Extreme Value
             k = -0.36064, sigma = 1.6488, mu = -0.92152

Case = 3-Copula Symmetric
Selected by = Akaike Information Criterion
Fittest copula:
 Copula Name = Gaussian
 param1 = 
    1.0000    0.7223    0.3642
    0.7223    1.0000    0.3652
    0.3642    0.3652    1.0000

Goodness-of-fits:
 AIC (Joint PDF) = 906.6
 CvM  = 0.023
 RMSE = 0.015
 pVal = 0.725
```
You can see the [step-by-step](symmetric-3-copula.md) for more details.

## Joint CDF and Joint PDF

The joint CDF and joint PDF values can be returned in the same way.

```matlab
jpdf = jointpdf(C,x);
jcdf = jointcdf(C,x);
```

**Download**: this example is available on `demo4.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
