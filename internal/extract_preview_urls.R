#' Title
#'
#' @param max_n_spcs int,
#' @param ... passed on to other methods.
#'
#' @return
#'
extract_preview_urls <- function(query, max_n_spcs = 3, ...) {
	remote_driver <- create_remote_driver(check = FALSE, ...)

	page_number <- 0
	preview_urls <- character()
	next_preview_urls <- "dummy" # initialise as non-empty

	while (length(preview_urls) < max_n_spcs & length(next_preview_urls) > 0) {
		url <- sprintf("http://produktresume.dk/AppBuilder/search?utf8=✓&q=%s&page=%s",
					   query, page_number)
		remote_driver$navigate(url)

		Sys.sleep(10)
		# TODO: Make responsive to when the page actually loaded,
		# 	similar in spirit to https://stackoverflow.com/q/43402237

		next_preview_urls <- remote_driver$findElements(using = "class", value = "preview_link") %>%
			sapply(function(link) link$getElementAttribute(attrName = "href")) %>%
			unlist()

		n_preview_urls_to_extract <- min(max_n_spcs - length(preview_urls),
										 length(next_preview_urls))
		preview_urls_to_append <- next_preview_urls[seq_len(n_preview_urls_to_extract)]
		preview_urls <- c(preview_urls, preview_urls_to_append)

		page_number <- page_number + 1
	}

	remote_driver$close()
	rm(remote_driver); gc(verbose = FALSE) # kill server process

	return(preview_urls)
}
