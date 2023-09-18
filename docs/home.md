---
permalink: /
---
# Getting Started

mycopula is a routine in MATLAB that is prepared to carry out the computational process on copula-based modeling.

mycopula provides a very easy way to estimate copula parameters and calculate joint PDF and CDF.

Some of the computing processes include Marginal Distribution Fittings, Copula Function Fittings, Visualization of Two Dimensional Copulas, and Regression Process.

The marginal distribution functions used are

- Continuous: Extreme Value, Generalized Extreme Value, Logistic, Normal, Exponential, Gamma, Inverse Gaussian, Log logistic, Lognormal, and Weibull distributions.
- Discrete: Negative Binomial distribution.

The copula functions used are Gaussian, t-student, Gumbel, Frank, Clayton, Joe, Galambos, BB1, BB6, BB7, and BB8.

## List of Functions

|Function|Description|
|:-|:-|
|`fitter`|fitting marginal distribution|
|`copfitter`|fitting copula using transformed variables|
|`bivariatefit`|one-line code for fitting bivariate copula|
|`symmetricfit`|one-line code for fitting trivariate copula|
|`nestedfit`|one-line code for fitting high-dimensional copula via nested structures|
|`biplot`|plot joint PDF via bivariate copula|
|`jointcdf`|compute the joint CDF using fitted copula|
|`jointpdf`|compute the joint PDF using fitted copula|
|`copreg`|Perform copula regression with different copula fitting approach|

## Menu

1. [What is copula?](what-is-copula.md)
    - [Definition of Copula and Sklar's Theorem](definition.md)
    - [Advantage and Disadvantage](advantage.md)
    - [Parameter Estimation Method](parameter.md)
2. Bivariate Case
    - [Fitting Bivariate Copula (Step-by-step)](fitting-bivariate-copula.md)
    - [Fitting Bivariate Copula (One-line Code)](fitting-bivariate-copula-one-line.md)
    - [Joint Probability Density Function and Its Visualization](joint-pdf.md)
    - [Copula Regression (One predictor)](copula-regression-one-predictor.md)
3. Trivariate Case (Symmetric 3-Copula)
    - [Fitting Symmetric 3-copula (Step-by-step)](symmetric-3-copula.md)
    - [Fitting Symmetric 3-copula (One-line code)](symmetric-3-copula-one-line.md)
    - [Copula regression (2 predictors) via symmetric copula](copula-regression-symmetric.md)
4. Multivariate Copula: Nested copula 
    - [Fitting Fully Nested Copula](fully-nested-copula.md)
    - [Copula regression (multiple predictors) via nested copula](copula-regression-nested.md)

## Download

Download the package for MATLAB [**here**](https://github.com/mkhoirun-najiboi/mycopula/archive/refs/heads/main.zip) or [visit GitHub](https://github.com/mkhoirun-najiboi/mycopula)

---
[< Home](home.md)\
[< Menu](home.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
