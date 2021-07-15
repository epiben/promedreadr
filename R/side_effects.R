#' Fetch ADE tables from product pages
#'
#' ADE tables are fetches if they exist (based on a quite simplistic heuristic about their content.)
#'
#' @param url character vector, full URL(s) for product page(s).
#'
#' @return
#'
#' @importFrom magrittr %>%
#'
#' @export

fetch_ade_tables <- function(url) {
	# TODO: Make recursion a method instead
	
	if (length(url) > 1) {
		return(map_valid(url, fetch_ade_tables))
	} else if (is.null(url)) {
		return(NULL)
	}
	
	frequency_labels <- c("almindelige", # covers very common, common and not common
						  "sjældne", # covers rare and very rare
						  "ikke kendt" # unknown
						  )
	frequency_regex <- paste(sprintf("(%s)", frequency_labels), collapse = "|")
	
	out <- rvest::read_html(url) %>%
		rvest::html_elements("table") %>%
		purrr::map(rvest::html_table) %>%
		purrr::keep(~ any(grepl(frequency_regex, .[, 1], ignore.case = TRUE))) %>%
		purrr::map(dplyr::transmute,
				   frequency = X1,
				   ades = stringr::str_replace_all(X2, c(".\\r\\n" = ", 
				   									  ", "\\s+" = " ", 
				   									  ".$" = ""))
				   )

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
#' @return
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
reconcile_ade_tables <- function(ade_tables, ...) {
	if (length(ade_tables) > 1 & is.null(list(...)$level)) {
		return(map_valid(ade_tables, reconcile_ade_tables, level = 2))
	}
	
	# Unname avoids warning "Outer names are only allowed for unnamed scalar 
	# atomic inputs" from dplyr::bind_rows()
	unname(ade_tables) %>% 
		dplyr::bind_rows() %>%
		dplyr::mutate(frequency = forcats::fct_inorder(frequency)) %>% 
			# ensure correct ordering after summarising
		dplyr::group_by(frequency) %>%
		dplyr::summarise(ades = find_unique_set(ades),
						 .groups = "drop") %>%
		dplyr::mutate(frequency = as.character(frequency)) 
			# avoid downstream weirdness due to factor type
}

#' Make a single-line strings with all ADEs, still grouped by frequency
#'
#' @param ade_table data frame with appropriate layout
#' @inheritDotParams reconcile_ade_tables
#'
#' @return
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
simplify_ades <- function(ade_table, ...) {
	if (length(ade_table) > 1 & is.null(list(...)$level)) {
		return(map_valid(ade_table, simplify_ades, level = 2))
	}
	
	with(ade_table, sprintf("%s: %s", frequency, ades)) %>%
		paste(collapse = " | ")
}

