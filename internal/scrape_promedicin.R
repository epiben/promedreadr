atc_codes <- c(Acetylcysteine = "V03AB23",
			   Allopurinol = "M04AA01")

all_urls <- extract_product_urls(atc_codes)
all_tables <- map(all_urls, fetch_ade_tables)
final_tables <- map_valid(all_tables, reconcile_ades)
oneline_ades <- map_valid(final_tables, simplify_ades)
