#' Fetch ADE tables from product pages
#'
#' ADE tables are fetches if they exist (based on a quite simplistic heuristic about their content.)
#'
#' @param url character vector, full URL(s) for product page(s).
#' @inheritParams extract_product_urls
#'
#' @return Side effects in tidy tibble.
#'
#' @export
#' 
fetch_ade_tables <- function(url, sleep_time = 1) {
	# TODO: Make recursion a method instead
	
	if (length(url) > 1) {
		return(map_valid(url, fetch_ade_tables))
	} 
	
	if (is.na(url) | is.null(url)) {
		return(NULL)
	}
	
	Sys.sleep(sleep_time)
	
	frequency_labels <- c("almindelige", # covers very common, common and not common
						  "sj\u00e6ldne", # sjældne; covers rare and very rare
						  "ikke kendt" # unknown
						  )
	frequency_regex <- paste(sprintf("(%s)", frequency_labels), collapse = "|")
	
	replacements <- c("\\r\\n\\s+\\(" = " \\(", 
					  ".\\r\\n\\s+" = ", ", 
					  "\\s+" = " ", 
					  ".$" = "")
	
	out <- rvest::read_html(url) %>%
		rvest::html_elements("table") %>%
		purrr::map(rvest::html_table) %>%
		purrr::keep(~ !rlang::is_empty(.)) %>% 
		purrr::keep(~ any(grepl(frequency_regex, .[, 1], ignore.case = TRUE))) %>%
		purrr::map(dplyr::transmute,
				   frequency = X1,
				   side_effects = stringr::str_replace_all(X2, replacements)) %>% 
		purrr::map(dplyr::mutate,
				   side_effects = lapply(side_effects, split_list)) %>% 
		purrr::map(tidyr::unnest, 
				   cols = "side_effects")
	
	if (length(out) > 0) {
		return(out)
	} else {
		return(NULL)
	}
}

#' Title
#'
#' @param ade_tables list of data frame with appropriate layout
#' @param ... used for recursion, anything specified will be ignored
#'
#' @return One tibble per ATC with the union of side effects reported for
#'   products with that ATC.
#'
#' @export
#' 
reconcile_ade_tables <- function(ade_tables, ...) {
	if (length(ade_tables) > 1 & is.null(list(...)$level)) {
		return(map_valid(ade_tables, reconcile_ade_tables, level = 2))
	}
	
	if (all(sapply(ade_tables, is.null))) {
		return(NULL)
	}
	
	# Specify levels to ensure correct ordering
	frequency_levels <- c("Meget almindelige (> 10 %)",
						  "Almindelige (1-10 %)", 
						  "Ikke almindelige (0,1-1 %)",
						  "Sj\u00e6ldne (0,01-0,1 %)", # sjældne
						  "Meget sj\u00e6ldne (< 0,01 %)", # idem
						  "Ikke kendt")
	
	# unname() avoids warning "Outer names are only allowed for unnamed scalar 
	# atomic inputs" from dplyr::bind_rows()
	unname(ade_tables) %>% 
		dplyr::bind_rows() %>% 
		dplyr::mutate(frequency = factor(frequency, levels = frequency_levels)) %>% 
		dplyr::distinct(frequency, side_effects) 
}

#' Make a single-line strings with all ADEs, still grouped by frequency
#'
#' @param ade_table data frame with appropriate layout
#' @param sep string, the separator between side effect frequency groups
#' @inheritDotParams reconcile_ade_tables
#'
#' @return String or perhaps vector of strings, depending on input.
#'
#' @export
#'
simplify_ades <- function(ade_table, sep = " | ", ...) {
	if (length(ade_table) > 1 & is.null(list(...)$level)) {
		return(map_valid(ade_table, simplify_ades, level = 2))
	}
	
	ade_table %>% 
		dplyr::group_by(frequency) %>% 
		dplyr::summarise(side_effects = paste(side_effects, collapse = ", ")) %>% 
		with(sprintf("%s: %s", frequency, side_effects)) %>%
		paste(collapse = sep)
}

