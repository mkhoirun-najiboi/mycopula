# Copula Regression (One predictor)

## Example 1: Stock Returns

```matlab
load stockreturns
x = stocks(:,1);
y = stocks(:,2);
[yhat,CI] = copulareg(x,y);
```

```plaintext
# ===== OUTPUT ======
Marginal: X
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Logistic
Parameters: mu = -0.19364, sigma = 0.58158
Decision: fails to reject h0 (AD pval=0.9990)
 
Marginal: Y
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Generalized Extreme Value
Parameters: k = -0.21362, sigma = 1.1975, mu = -0.66838
Decision: fails to reject h0 (AD pval=0.9949)
 
Case = Bivariate
Sort by = Akaike Information Criterion
Fittest copula = Gaussian
Parameter(s): param1 = 0.72231
Decision: fails to reject h0 (CvM pval=0.7361)

Regression Progress: 100.00%
Data length for fitting = 100
Data length for predicting = 100
Evaluation Results:
RMSE = 0.86371
MAPE = 2.1655
wMAPE = 0.67043
```

<img width=500px src="img/reg1.jpg">

## Example 2: Poly Data

```matlab
load polydata
x = x(:);
y = y(:);
[yhat,CI] = copulareg(x,y);
```

```plaintext
# ===== OUTPUT ======
Marginal: X
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Generalized Extreme Value
Parameters: k = 0.35086, sigma = 0.60886, mu = 0.6834
Decision: fails to reject h0 (AD pval=0.5629)
 
Marginal: Y
Domain = Positive
Sort by = Anderson-Darling Stastistics
fittest distribution = Normal
Parameters: mu = 6.7738, sigma = 1.2902
Decision: fails to reject h0 (AD pval=0.6547)
 
Case = Bivariate
Sort by = Akaike Information Criterion
Fittest copula = Galambos-180
Parameter(s): param1 = 2.9063
Decision: fails to reject h0 (CvM pval=0.5655)

Regression Progress: 100.00%
Data length for fitting = 43
```

<img width=500px src="img/reg2.jpg">

**Download**: this example is available on `demo3.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
