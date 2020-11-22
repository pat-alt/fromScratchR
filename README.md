
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
#> [1,]  1.000000e+00  1.110223e-16 -1.682682e-16 -1.509209e-16  7.914676e-18
#> [2,]  1.110223e-16  1.000000e+00  2.775558e-17 -1.144917e-16 -6.938894e-18
#> [3,] -1.682682e-16  2.775558e-17  1.000000e+00 -4.163336e-17 -2.682316e-16
#> [4,] -1.509209e-16 -1.144917e-16 -4.163336e-17  1.000000e+00  1.123233e-16
#> [5,]  7.914676e-18 -6.938894e-18 -2.682316e-16  1.123233e-16  1.000000e+00
```
