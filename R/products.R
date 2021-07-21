#' Extract full URLs for product with a given ATC code
#'
#' @param atc string, potentially a vector
#'
#' @return character vector of full URLs to products that appear when querying pro.medicin.dk for the input ATC.
#'
#' @importFrom magrittr %>%
#'
#' @export

extract_product_urls <- function(atc) {
	if (length(atc) > 1) {
		return(purrr::map(atc, extract_product_urls))
	}

	paths <- paste0("https://pro.medicin.dk/Search/Search/Search/", atc) %>%
		rvest::read_html() %>%
		rvest::html_elements("a.glob-search_link") %>%
		rvest::html_attr("href") %>%
		lapply(function(x) grep("/Medicin/Praeparater/", x, value = TRUE)) %>%
		unlist()
	
	if (length(paths) > 0) {
		urls <- paste0("https://pro.medicin.dk", paths)
		urls <- stats::setNames(urls, fetch_product_name(urls))
		return(urls)
	} else {
		return(NULL)
	}

}

#' Fetch product name from product page
#'
#' @param url string, full URL to product page on pro.medicin.dk. Maybe be a vector of several URLs
#' @param sleep_time number, number of seconds to hault execution, useful for avoiding loading a large number of pages in a very short amount of time.
#'
#' @return Title of product page as character.
#' @export
#'
fetch_product_name <- function(url, sleep_time = 1) {
	if (length(url) > 1) {
		return(purrr::map_chr(url, fetch_product_name))
	}
	
	Sys.sleep(sleep_time)
	
	rvest::read_html(url) %>% 
		rvest::html_element("h1.ptitle") %>% 
		rvest::html_text() %>% 
		stringr::str_trim()
}