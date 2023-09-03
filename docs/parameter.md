<script type="text/javascript">
  window.MathJax = {
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
      processEscapes: true
    }
  };
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: { equationNumbers: { autoNumber: "AMS" } }
});
</script>
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

# Parameter Estimation

The inference of functions for margins (IFM) method is the most common method used to estimate the copula parameters. In the context of copula modeling, "inference of functions for margins" refers to the process of estimating the probability distribution functions (PDFs) or cumulative distribution functions (CDFs) of individual variables (margins) within a multivariate model. This step is important because copula models typically involve two main components: the joint distribution (captured by the copula) and the marginal distributions (captured by the margins). The IFM is specifically concerned with estimating the functions that describe the individual marginal distributions.

## Marginal Distribution Parameter

The IFM is a two-step method. The first step is to estimate the parameters of the marginal distribution of each variable. The marginal distributions are estimated by maximizing the log of the likelihood function, which is given by:
$$
\begin{align}
\hat{\alpha}=\arg\max\sum_{t=1}^{N}\ln f_i(x_i^t;\alpha_i)
\end{align}
$$
where $\hat{\alpha}$ is the estimated parameter of $\alpha$, and $f_i$ is the probability density function (PDF) of $X_i$ for $i = 1, 2$. The marginal distribution functions used are

- Continuous:
    - [Extreme Value](https://www.mathworks.com/help/stats/extreme-value-distribution.html),
    - [Generalized Extreme Value](https://www.mathworks.com/help/stats/generalized-extreme-value-distribution.html),
    - [Logistic](https://www.mathworks.com/help/stats/logistic-distribution.html),
    - [Normal](https://www.mathworks.com/help/stats/normal-distribution.html),
    - [Exponential](https://www.mathworks.com/help/stats/exponential-distribution.html),
    - [Gamma](https://www.mathworks.com/help/stats/gamma-distribution.html),
    - [Inverse Gaussian](https://www.mathworks.com/help/stats/inverse-gaussian-distribution.html),
    - [Log logistic](https://www.mathworks.com/help/stats/loglogistic-distribution.html),
    - [Lognormal](https://www.mathworks.com/help/stats/lognormal-distribution.html), and
    - [Weibull](https://www.mathworks.com/help/stats/weibull-distribution.html) distributions.
- Discrete:
    - [Negative Binomial](https://www.mathworks.com/help/stats/negative-binomial-distribution.html) distribution.

The fittest marginal univariate distribution is selected on the basis of

- [Akaike's Information Criterion](https://en.wikipedia.org/wiki/Akaike_information_criterion)
- [Kolmogorov-Smirnov statistic](https://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test)
- [Anderson-Darling statistic](https://en.wikipedia.org/wiki/Anderson%E2%80%93Darling_test) (_default_)

The _p_-value is estimated using Anderson–Darling statistic to perform the Anderson–Darling hypothesis test with the 5% significance level. If the p-value is larger than 5%, then the test fails to reject the null hypothesis, that is, the data are from a population with the selected distribution, $F(\cdot)$.

## Copula Parameter
The second step of the IFM method is to estimate the copula parameter by maximizing the log-likelihood function of copula density, which is given by:
$$
\begin{align}
\hat{\theta}=\arg\max\sum_{t=1}^{N}\ln c(F_1(x_1^t|\hat{\alpha}_1),F_2(x_2^t|\hat{\alpha}_2);\theta)
\end{align}
$$
where $\hat{\theta}$ is the estimated parameter of $\theta$, and $c$ is the copula density function. The copula functions used are 

- Gaussian, 
- t-student, 
- Gumbel, 
- Frank, 
- Clayton, 
- Joe, 
- Galambos, 
- BB1, 
- BB6, 
- BB7, and 
- BB8.

The fittest copula function is selected on the basis of several statistical tests, such as

- Root mean squared error of the theoretical and empirical frequencies,
- Akaike's Information Criterion,
- Cramer–von Mises statistic based on **Approach $A_2$** in [[1](#Berg)].

The theoretical frequency is obtained from the model of copula function, while the empirical frequency is estimated using Gringorten’s formula [[2](#Gringorten)].

Using the Cramer–von Mises statistic, the _p_-value is estimated to perform the Cramer–von Mises hypothesis test with the 5% significance level. If the _p_-value is greater than 5%, then the test fails to reject the null hypothesis, i.e., the data are from the selected theoretical copula, $C(\cdot)$.

For more details, read article [[3](#Najib)].

**References**\
[<a id="Berg">1</a>] Berg, D. (2009). Copula goodness-of-fit testing: an overview and power comparison. _The European Journal of Finance_, 15(7-8), 675–701.\
[<a id="Gringorten">2</a>] Gringorten, I. I. (1963). A plotting rule for extreme probability paper. _Journal of Geophysical Research_, 68(3), 813-814.\
[<a id="Najib">3</a>] Najib, M. K., Nurdiati, S., & Sopaheluwakan, A. (2022). Multivariate fire risk models using copula regression in Kalimantan, Indonesia. _Natural Hazards_, 113(2), 1263-1283.

---
[< Home](README.md)\
[< Menu](README.md#menu)\
[**View on Github**](https://github.com/mkhoirun-najiboi/mycopula)

[Visit my personal blog](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
