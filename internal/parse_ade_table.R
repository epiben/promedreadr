parse_ade_table <- function(scraped_html) {
	scraped_html$getElementAttribute('innerHTML')[[1]] %>%
		rvest::read_html() %>%
		paste("<table>", ., "</table>") %>%
		rvest::minimal_html() %>%
		rvest::html_element("table") %>%
		rvest::html_table(header = TRUE)
}
