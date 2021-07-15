#' Fetch adverse drug event table for a specific product
#'
#' @param preview_url
#'
#' @return

extract_ade_table <- function(preview_url, driver) {
	# Must be defined inside function to access the remove_driver object
	parse_ade_table <- function(scraped_html) {
		scraped_html$getElementAttribute('innerHTML')[[1]] %>%
			rvest::read_html() %>%
			paste("<table>", ., "</table>") %>%
			rvest::minimal_html() %>%
			rvest::html_element("table") %>%
			rvest::html_table(header = TRUE)
	}

	driver$navigate(preview_url)
	Sys.sleep(10) # TODO: make responsive

	browser()
	ade_table <- driver$findElements(using = "xpath", value = "/html/body/table") %>%
		lapply(parse_ade_table) %>%
		purrr::keep(~ any(grepl("Systemorgan", names(.x)))) %>%
		dplyr::bind_rows() %>%
		dplyr::mutate(dplyr::across(dplyr::everything(), tidyr::replace_na, replace = ""))

	rm(driver); gc(verbose = FALSE) # kill server process

	return(ade_table)
}
