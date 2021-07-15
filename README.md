
<!-- README.md is generated from README.Rmd. Please edit that file -->
# promedreadr

<!-- badges: start -->
[![Build Status](https://travis-ci.org/epiben/promedreadr?branch=master)](https://travis-ci.org/epiben/promedreadr) <!-- badges: end -->

The goal of `promedreadr` is to provide a simple tool for collecting information from <https://pro.medicin.dk>, a key reference on medicines marketed in Denmark.

## Features

-   Simple interface for querying based on ATC codes
-   Can marshal information from all products containing drugs with the queried ATC code(s)
-   Reconciles side effects reported for all products and roll them up to the ATC code(s)
-   Provides a simple way to obtain single-line lists of side effects, ordered by frequencies

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(promedreadr)

atc_codes <- c(Quetiapin = "N05AH04",
               Lithium = "N05AN01")

product_urls <- extract_product_urls(atc_codes)
all_ade_tables <- fetch_ade_tables(product_urls)
final_ade_tables <- reconcile_ade_tables(all_ade_tables)

simplify_ades(final_ade_tables)
```

## Installation

`promedreadr` isn't yet on CRAN, but you can install it easily directly from GitHub [GitHub](https://github.com/) with (you may need to install the `devtools` package first):

``` r
# install.packages("devtools")
devtools::install_github("epiben/promedreadr")
```

## Contributing

We use the [GitHub issue tracker](https://www.github.com/epiben/promedreadr/issues) for all bugs/issues/enhancements

## License

`promedreadr` is licensed under MIT lience.

## Development and status

promedreadr\` is developed in RStudio and maturing under active development.

## Acknowledgements

-   The package maintainer received funding from Innovation Fund Denmark (5153-00002B) and the Novo Nordisk Foundation (NNF14CC0001).
