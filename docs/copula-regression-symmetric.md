# Copula Regression (Two predictor) using Symmetric 3-Copula

## Load data

Define predictor data x and response y.

```matlab
load stockreturns
x = stocks(:,2:3);
y = stocks(:,1);
```

## Perform regression

Use that data to perform a regression.

```matlab
yhat = copreg(x,y,'xpred',x,'ypred',y,'method','Symmetric');
```

```plaintext
# ===== OUTPUT =====
Fit copula (X,Y)
Fit copula (X)
Case: 2-predictor
Method: Symmetric
Regression Progress: 100.00%
Data length for fitting = 100
Data length for predicting = 100
Evaluation Results:
RMSE = 0.71005
MAPE = 5.4866
wMAPE = 0.69696
```

_Note_: The `symmetric` method only applies to the case of two predictors.

**Download**: this example is available on `demo5.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
