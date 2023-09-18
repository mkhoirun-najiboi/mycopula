# my copula
mycopula is a routine in MATLAB that is prepared to carry out the computational process on copula-based modeling.

mycopula provides a very easy way to estimate copula parameters and calculate joint PDF and CDF.

see [documentation](https://mkhoirun-najiboi.github.io/mycopula/)


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