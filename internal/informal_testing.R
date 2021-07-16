library(promedreadr)
library(dplyr)

atc_codes <- c(Quetiapin = "N05AH04",
			   Fluconazol = "J02AC01",
			   Lithium = "N05AN01")

final_tables <- extract_product_urls(atc_codes) %>% 
	fetch_ade_tables() %>% 
	reconcile_ades()

simplify_ades(final_tables)
