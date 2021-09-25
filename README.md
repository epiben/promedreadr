
<!-- README.md is generated from README.Rmd. Please edit that file -->

# promedreadr

<!-- badges: start -->

[![Build
Status](https://travis-ci.com/epiben/promedreadr.svg?token=jPFag7F7DJzmhXYLiSqy&branch=main)](https://travis-ci.com/epiben/promedreadr)
![Version](https://img.shields.io/badge/version-0.1.0-informational.svg)
<!-- badges: end -->

The goal of `promedreadr` is to provide a simple tool for collecting
information from <https://pro.medicin.dk>, a key reference on medicines
marketed in Denmark.

Note that the package is not yet “production ready”, especially it
doesn’t yet honour robots.txt (this improvement is underway and will be
up shortly.)

## Just because you can doesn’t mean you should

Please use this package thoughtfully as web-scraping can lead to
e.g. copyright infringement. If in doubt, please contact the team behind
[medicin.dk](https://www.medicin.dk).

## Features

-   Simple interface for querying based on ATC codes
-   Marshals information from all products containing drugs with the
    queried ATC code(s)
-   Reconciles side effects reported across products and rolls them up
    to the ATC code(s)
-   Can produce handy, single-line lists of side effects, by frequencies

## Example

``` r
library(promedreadr)

atc_codes <- c(Quetiapin = "N05AH04",
               Lithium = "N05AN01")

product_urls <- extract_product_urls(atc_codes)
all_ade_tables <- fetch_ade_tables(product_urls)
combined_ade_tables <- reconcile_ade_tables(all_ade_tables)

combined_ade_tables
#> $Quetiapin
#> # A tibble: 65 × 2
#>    frequency side_effects          
#>    <fct>     <chr>                 
#>  1 <NA>      Anæmi                 
#>  2 <NA>      Mundtørhed            
#>  3 <NA>      Abstinenser*          
#>  4 <NA>      Svimmelhed            
#>  5 <NA>      Nedsat HDL            
#>  6 <NA>      Vægtøgning            
#>  7 <NA>      Hyperkolesterolæmi    
#>  8 <NA>      Hypertriglyceridæmi   
#>  9 <NA>      Ekstrapyramidale gener
#> 10 <NA>      Hovedpine             
#> # … with 55 more rows
#> 
#> $Lithium
#> # A tibble: 55 × 2
#>    frequency side_effects               
#>    <fct>     <chr>                      
#>  1 <NA>      Vægtøgning                 
#>  2 <NA>      Nefrogen diabetes insipidus
#>  3 <NA>      Hypertyroidisme            
#>  4 <NA>      Hypotyroidisme             
#>  5 <NA>      Struma                     
#>  6 <NA>      Abdominalsmerter           
#>  7 <NA>      Diarré                     
#>  8 <NA>      Kvalme                     
#>  9 <NA>      Eeg-forandringer           
#> 10 <NA>      Ekg-forandringer           
#> # … with 45 more rows
```

## Installation

`promedreadr` isn’t yet on CRAN, but you can install it easily directly
from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools") # if not already installed
devtools::install_github("epiben/promedreadr")
```

## Contributing

We use the [GitHub issue
tracker](https://www.github.com/epiben/promedreadr/issues) for all
bugs/issues/enhancements

## License

`promedreadr` is licensed under the MIT licence.

## Development and status

`promedreadr` is developed in RStudio and maturing under active
development.

## Acknowledgements

The package maintainer received funding from Innovation Fund Denmark
(5153-00002B) and the Novo Nordisk Foundation (NNF14CC0001).
