# Copula Regression (Multiple predictors) using Nested Copula

## Case: 2 Predictors

**Load data**\
Define predictor data x and response y.

```matlab
load stockreturns
x = stocks(:,2:3);
y = stocks(:,1);
```

**Perform regression (2 Predictors)**\
Use that data to perform a regression.

```matlab
[yhat,CI] = copreg(x,y,'xpred',x,'ypred',y,'method','nested');
```

```plaintext
# ===== OUTPUT =====
Fit copula (X,Y)
Fitting Progress: 2/2
Fit copula (X)
Fitting Progress: 1/1
Case: 2-predictor
Method: nested
Regression Progress: 100.00%
Data length for fitting = 100
Data length for predicting = 100
Evaluation Results:
RMSE = 0.71676
MAPE = 5.4411
wMAPE = 0.69542
```

## Case: 7 Predictors

Define predictor data x and response y. Use that data to perform a regression.

```matlab
load stockreturns
x = stocks(:,2:8);
y = stocks(:,1);
[yhat,CI] = copreg(x,y,'xpred',x,'ypred',y,'method','nested');
```

```plaintext
# ===== OUTPUT =====
Fit copula (X,Y)
Fitting Progress: 7/7
Fit copula (X)
Fitting Progress: 6/6
Case: 7-predictor
Method: nested
Regression Progress: 100.00%
Data length for fitting = 100
Data length for predicting = 100
Evaluation Results:
RMSE = 1.0125
MAPE = 4.134
wMAPE = 0.9
```

**Download**: this example is available on `demo6.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
