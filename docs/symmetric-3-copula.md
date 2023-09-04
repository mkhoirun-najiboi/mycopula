# Symmetric 3-Copula

```matlab
load stockreturns
X1 = stocks(:,1);
X2 = stocks(:,2);
X3 = stocks(:,3);

F1 = fitter(X1); U1 = cdf(F1,X1);
F2 = fitter(X2); U2 = cdf(F2,X2);
F3 = fitter(X3); U3 = cdf(F3,X3);

C = copfitter([U1,U2,U3],'verbosity',3);
```

```plaintext
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Logistic
Parameters: mu = -0.19364, sigma = 0.58158
Decision: fails to reject h0 (AD pval=0.9990)
 
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Generalized Extreme Value
Parameters: k = -0.21362, sigma = 1.1975, mu = -0.66838
Decision: fails to reject h0 (AD pval=0.9949)
 
Domain = Real
Sort by = Anderson-Darling Stastistics
fittest distribution = Generalized Extreme Value
Parameters: k = -0.36064, sigma = 1.6488, mu = -0.92152
Decision: fails to reject h0 (AD pval=0.9536)
 
Case = Symmetric Trivariate
Sort by = Akaike Information Criterion
Fittest copula = Gaussian
Parameter: param1 = 
    1.0000    0.7223    0.3642
    0.7223    1.0000    0.3652
    0.3642    0.3652    1.0000

Decision: fails to reject h0 (CvM pval=0.7248)
Summary = 
 
     copulaName        param1           param2          CvM       pValue       RMSE        AIC  
    ____________    ____________    ______________    ________    _______    ________    _______

    {'Gaussian'}    {3×3 double}    {0×0 double  }    0.023096    0.72483    0.015197    -88.511
    {'t'       }    {3×3 double}    {[1.2699e+08]}    0.031971    0.68688    0.017881    -86.512
    {'Gumbel'  }    {[  1.4082]}    {0×0 double  }     0.06333      0.568    0.025165    -58.982
    {'Frank'   }    {[  2.8937]}    {0×0 double  }    0.044194    0.63784    0.021022    -54.603
    {'Joe'     }    {[  1.5664]}    {0×0 double  }     0.12503    0.39082    0.035359    -48.461
    {'Clayton' }    {[  0.5799]}    {0×0 double  }     0.11185     0.4233    0.033444     -43.63

```

**Download**: this example is available on `demo4.m`. [Visit Github](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
