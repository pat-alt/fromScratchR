
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fromScratchR

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

[fromScratchR](https://github.com/pat-alt/fromScratchR) is the
accompanying package of
[fromScratch](https://github.com/pat-alt/fromScratch) - a book that
collects ideas, notes, exercises and code that students of the MSc in
Data Science at Barcelona GSE were exposed and/or came up with during
their studies. Both the book and this package are meant for educational
purposes and cover a broad range of topics. The package primarily serves
the purpose of making it easier for readers of the book to engage with
relevant R code. Most if not all functions implemented in this package
have already been implemented in established packages. Coding them up
*from scratch* is an educational exercise for the authors and hopefully
interacting with the code is beneficial to readers.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("pat-alt/fromScratchR")
```

## Example

Below is a simple example of a function from the book. `rorthogonal`
generates a random orthogonal matrix through singular value
decomposition.

``` r
library(fromScratchR)
## basic example code
X <- rorthogonal(n=100,5)
crossprod(X)
#>               [,1]          [,2]          [,3]          [,4]          [,5]
#> [1,]  1.000000e+00 -3.474732e-16 -6.028164e-17 -3.021671e-16 -7.432206e-17
#> [2,] -3.474732e-16  1.000000e+00 -8.500145e-17 -1.812786e-16 -1.057639e-16
#> [3,] -6.028164e-17 -8.500145e-17  1.000000e+00  1.769418e-16  1.925543e-16
#> [4,] -3.021671e-16 -1.812786e-16  1.769418e-16  1.000000e+00  1.045171e-16
#> [5,] -7.432206e-17 -1.057639e-16  1.925543e-16  1.045171e-16  1.000000e+00
```
