# Fitting Bivariate Copula (One-line code)

In addition to providing how to construct copulas [step-by-step](fitting-bivariate-copula.md), we also provide how to construct copulas with just one line.

**Load Data**\
With the same example data as before, here is how.

```matlab
load stockreturns
x = stocks(:,1:2);
```

#### Fit Copula
And this is how it fits.

```matlab
C = bivariatefit(x);
```

```text
#============= OUTPUT =============
Marginal Distribution: 
 No. 1: Dist Name = Logistic
             mu = -0.19364, sigma = 0.58158
 No. 2: Dist Name = Generalized Extreme Value
             k = -0.21362, sigma = 1.1975, mu = -0.66838

Case = Bivariate Copula
Selected by = Akaike Information Criterion
Fittest copula:
 Copula Name = Gaussian
 param1 = 0.7223

Goodness-of-fits:
 AIC (Joint PDF) = 546.8
 CvM  = 0.021
 RMSE = 0.014
 pVal = 0.736
```

This is very easy. With just one line of code, we can fit the copula. And above is a summary of the fitting process.

**Download**: this example is available on `demo1.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
