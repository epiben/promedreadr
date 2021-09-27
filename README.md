
<!-- README.md is generated from README.Rmd. Please edit that file -->

# promedreadr

<!-- badges: start -->

[![Build
Status](https://app.travis-ci.com/epiben/promedreadr.svg?branch=main)](https://app.travis-ci.com/epiben/promedreadr)
![Version](https://img.shields.io/badge/version-0.1.0-informational.svg)
<!-- badges: end -->

The goal of `promedreadr` is to provide a simple tool for collecting
information from <https://pro.medicin.dk>, a key reference on medicines
marketed in Denmark.

Note that the package is not yet “production ready”, especially it
doesn’t yet honour robots.txt (improvement is underway and will be up
shortly.)

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
#>    frequency                  side_effects          
#>    <fct>                      <chr>                 
#>  1 Meget almindelige (> 10 %) Anæmi                 
#>  2 Meget almindelige (> 10 %) Mundtørhed            
#>  3 Meget almindelige (> 10 %) Abstinenser*          
#>  4 Meget almindelige (> 10 %) Svimmelhed            
#>  5 Meget almindelige (> 10 %) Nedsat HDL            
#>  6 Meget almindelige (> 10 %) Vægtøgning            
#>  7 Meget almindelige (> 10 %) Hyperkolesterolæmi    
#>  8 Meget almindelige (> 10 %) Hypertriglyceridæmi   
#>  9 Meget almindelige (> 10 %) Ekstrapyramidale gener
#> 10 Meget almindelige (> 10 %) Hovedpine             
#> # … with 55 more rows
#> 
#> $Lithium
#> # A tibble: 55 × 2
#>    frequency                  side_effects               
#>    <fct>                      <chr>                      
#>  1 Meget almindelige (> 10 %) Vægtøgning                 
#>  2 Meget almindelige (> 10 %) Nefrogen diabetes insipidus
#>  3 Almindelige (1-10 %)       Hypertyroidisme            
#>  4 Almindelige (1-10 %)       Hypotyroidisme             
#>  5 Almindelige (1-10 %)       Struma                     
#>  6 Almindelige (1-10 %)       Abdominalsmerter           
#>  7 Almindelige (1-10 %)       Diarré                     
#>  8 Almindelige (1-10 %)       Kvalme                     
#>  9 Almindelige (1-10 %)       Eeg-forandringer           
#> 10 Almindelige (1-10 %)       Ekg-forandringer           
#> # … with 45 more rows
```

## Installation

`promedreadr` isn’t yet on CRAN, but you can install it easily directly
from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools") # if not already installed
remotes::install_github("epiben/promedreadr")
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
