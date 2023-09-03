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

# Definition of Copula

A copula is a statistical concept used in probability theory and multivariate statistics to describe the dependence structure between random variables. It is particularly useful when dealing with complex, high-dimensional data where the relationships between variables are not easily described by traditional methods. Copulas have applications in fields such as finance, economics, and environmental science [[1](#MKN23a),[2](#MKN23b)], among others.

Copulas are used to model the dependence or association between multiple random variables. In many cases, it's essential to understand how variables co-move or interact with each other, and copulas provide a way to quantify and analyze this dependence.

Copulas separate the modeling of marginal distributions from the modeling of the joint distribution. This means you can specify the individual probability distributions for each variable (marginal distributions) separately from how they are related to each other.

Copulas allow for the modeling of various types of dependence structures, including positive or negative correlations, asymmetry (skewness), and tail behavior. This flexibility is particularly valuable when dealing with real-world data, which often exhibits complex patterns of dependence.

Copulas are a powerful tool for modeling the dependence structure between random variables, allowing statisticians and data scientists to capture and analyze complex relationships in data while preserving the flexibility to work with different types of marginal distributions.

## Main Idea

The central idea of copula theory is to separate the modeling of marginal distributions from the modeling of the joint distribution, allowing for more flexible and comprehensive descriptions of dependence patterns.

The copula function presents an alternative way to build a joint distribution in cases where the assumption of normality is not met. When faced with marginal variables that are not normally distributed, copula facilitates the creation of a joint distribution. Remarkably, this construction is still feasible even when each variable shows a different distribution. Copula, functions as a connector, building multivariate joint distribution function through the marginal univariate distribution function. Another perspective, copula function is a multivariate distribution function, where marginal functions are uniformly distributed in $[0,1]$.

## Mathematical Formulation
Before defining copulas, we first define subcopulas as a certain class of grounded 2-increasing functions with margins; then we define copulas as subcopulas with domain $I^2$ where $I = [0,1]$.

> **Definition 1**:  A two-dimensional subcopula (or 2-subcopula, or briefly, a subcopula) is a function $C'$ with the following properties:
> 1. Domain $C'=S_1\times S_2$ where $S_1$ and $S_2$ are subsets of $I$ containing 0 and 1;
> 2. $C'$ is grounded and 2-increasing;
> 3. For every $u$ in $S_1$ and every $v$ in $S_2$,
\begin{align}
C'(u,1)=u \textrm{ and } C'(1,v)=v
\end{align}

Note that for every $(u,v)$ in Domain $C'$, $0\le C'(u,v)\le1$, so that Range $C'$ is also a subset of $I$.

> **Definition 2**: A two-dimensional copula (or 2-copula, or briefly, a copula) is a 2-subcopula $C$ whose domain is $I^2$.

Equivalently, a copula is a function $C$ from $I^2$ to $I$ with the following properties:

1. For every $u, v$ in $I$,
$$\begin{align}
C(u,0)=C(0,v)=0
\end{align}$$
and
$$\begin{align}
C(u,1)=u \textrm{ and } C(1,v)=v
\end{align}$$
2. For every $u_1, u_2, v_1, v_2$ in $I$ such that $u_1\le u_2$ and $v_1\le v_2$,
$$
\begin{align}
C(u_2,v_2)-C(u_1,v_2)-C(u_2,v_1)+C(u_1,v_1)\ge0
\end{align}
$$

> **Proposition 1**: The horizontal, vertical, and diagonal sections of a copula $C$ are all nondecreasing and uniformly continuous on $I$.

For more details about the definition and basic properties of copula, you can read the textbook [[3](#nelsen)].

## Sklar's Theorem
This theorem is central to the theory of copulas and is the foundation of many, if not most, of the applications of that theory to statistics. Sklar’s theorem elucidates the role that copulas play in the relationship between multivariate distribution functions and their univariate margins. Thus we begin this section with a short discussion of distribution functions.

> **Definition 3**:  A _distribution function_ is a function $F$ with domain $\bar{R}$ such that
> 1. $F$ is non-decreasing,
> 2. $F(–\infty) = 0$ and $F(\infty) = 1$

> **Definition 4**: A _joint distribution function_ is a function $F_{XY}$ with domain $\bar{R}^2$ such that
> 1. $F_{XY}$ is 2-increasing,
> 2. $F_{XY}(x,-\infty)=F_{XY}(-\infty,y)=0$, and $F_{XY}(\infty,\infty)=1$.

Thus $F_{XY}$ is grounded, and because Domain $H = \bar{R}^2$ , $F_{XY}$ has margins $F_X$ and $F_Y$ given by $F_X(x) = F_{XY}(x,\infty)$ and $F_Y(y) = F_{XY}(\infty,y)$. By virtue of _Proposition 1_, $F_X$ and $F_Y$ are distribution functions.

> **Theorem 1 (Sklar's theorem)**: Let $F_{XY}$ be a joint distribution function with margins $F_X$ and $F_Y$. Then there exists a copula $C$ such that for all $x,y$ in $\bar{R}$,
$$
\begin{align}
F_{XY} = C(F_X(x),F_Y(y))
\end{align}
$$

This theorem first appeared in [[4](#Sklar)]. The name “copula” was chosen to emphasize the manner in which a copula “couples” a joint distribution function to its univariate margins.

**References**\
[<a id="MKN23a">1</a>] Najib, M. K., Nurdiati, S., & Sopaheluwakan, A. (2022). Copula-based joint distribution analysis of the ENSO effect on the drought indicators over Borneo fire-prone areas. _Modeling Earth Systems and Environment_, 8(2), 2817-2826.\
[<a id="MKN23b">2</a>] Najib, M. K., Nurdiati, S., & Sopaheluwakan, A. (2022). Multivariate fire risk models using copula regression in Kalimantan, Indonesia. _Natural Hazards_, 113(2), 1263-1283.\
[<a id="Nelsen">3</a>] Nelsen, R. B. (2006). _An introduction to copulas_. Springer.
[<a id="Sklar">4</a>] Sklar, M. (1959). Fonctions de Répartition àn Dimensions et Leurs Marges. _Publ L’institut Stat L’université Paris_, 8, 229–231.

---
[< Home](README.md)\
[< Menu](README.md#menu)\
Visit my blog: [emkanajib](https://emkanajib.blogspot.com/)\
@ 2021-2023 Mohamad Khoirun Najib
