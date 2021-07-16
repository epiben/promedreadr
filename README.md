
<!-- README.md is generated from README.Rmd. Please edit that file -->
# promedreadr

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/epiben/promedreadr.svg?branch=main)](https://travis-ci.com/epiben/promedreadr) <!-- badges: end -->

The goal of `promedreadr` is to provide a simple tool for collecting information from <https://pro.medicin.dk>, a key reference on medicines marketed in Denmark.

## Features

-   Simple interface for querying based on ATC codes
-   Marshals information from all products containing drugs with the queried ATC code(s)
-   Reconciles side effects reported across products and rolls them up to the ATC code(s)
-   Can produce handy, single-line lists of side effects, by frequencies

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(promedreadr)

atc_codes <- c(Quetiapin = "N05AH04",
               Lithium = "N05AN01")

product_urls <- extract_product_urls(atc_codes)
all_ade_tables <- fetch_ade_tables(product_urls)
combined_ade_tables <- reconcile_ade_tables(all_ade_tables)

combined_ade_tables
#> $Quetiapin
#> # A tibble: 6 x 2
#>   frequency             ades                                                    
#>   <chr>                 <chr>                                                   
#> 1 Meget almindelige (>… Abstinenser*, Anæmi, Døsighed, Ekstrapyramidale gener, …
#> 2 Almindelige (1-10%)   Abnorme drømme, Dysartri, Dyspepsi, Dyspnø, Eosinofili,…
#> 3 Ikke almindelige (0,… (herunder allergiske hudreaktioner), Bradykardi, Diabet…
#> 4 Sjældne (0,01-0,1%)   Agranulocytose, Dyb venetrombose, Hepatitis, Hypotermi,…
#> 5 Meget sjældne (< 0,0… Anafylaktisk reaktion, Angioødem, Rhabdomyolyse, Steven…
#> 6 Ikke kendt            Cerebrovaskulære tilfælde, DRESS - lægemiddelreaktion m…
#> 
#> $Lithium
#> # A tibble: 5 x 2
#>   frequency             ades                                                    
#>   <chr>                 <chr>                                                   
#> 1 Meget almindelige (>… Nefrogen diabetes insipidus, Vægtøgning                 
#> 2 Almindelige (1-10%)   Abdominalsmerter, Acne, Bevidsthedspåvirkning, Diarré, …
#> 3 Ikke almindelige (0,… Alopeci, Arytmier, AV-blok, Muskelsvaghed, Parkinsonism…
#> 4 Sjældne (0,01-0,1%)   Malignt neuroleptikasyndrom                             
#> 5 Ikke kendt            Agranulocytose, Artralgi, Ataksi, Benign intrakraniel t…
```

## Installation

`promedreadr` isn't yet on CRAN, but you can install it easily directly from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools") # if not already installed
devtools::install_github("epiben/promedreadr")
```

## Contributing

We use the [GitHub issue tracker](https://www.github.com/epiben/promedreadr/issues) for all bugs/issues/enhancements

## License

`promedreadr` is licensed under the MIT licence.

## Development and status

`promedreadr` is developed in RStudio and maturing under active development.

## Acknowledgements

The package maintainer received funding from Innovation Fund Denmark (5153-00002B) and the Novo Nordisk Foundation (NNF14CC0001).
