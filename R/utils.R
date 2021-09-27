#' Split in-line list containing subordinate lists inside brackets
#'
#' @param x string containing in-line list
#' @param sep character, separator. Default: \code{","}.
#'
#' @export
#'
split_list <- function(x, sep = ",") {
	inside_bracket <- FALSE
	
	xt <- unlist(stringr::str_split(x, pattern = ""))
	
	for (i in seq_along(xt)) {
		if (xt[i] == "(") {
			inside_bracket <- TRUE
		} else if (xt[i] == ")") {
			inside_bracket <- FALSE
		}
		
		if (xt[i] == stringr::str_trim(sep) & !inside_bracket) {
			xt[i] <- "[SEPARATOR]"
		}
	}
	
	paste(xt, collapse = "") %>% 
		stringr::str_split(stringr::coll("[SEPARATOR]")) %>% 
		unlist() %>% 
		stringr::str_trim()
}

#' Map non-null list elements with function
#'
#' @param x list whose elements should be mapped, except for NULL elements
#' @param fun function to apply
#' @param ... arguments passed to function
#'
#' @export
#' 
map_valid <- function(x, fun, ...) {
	purrr::map_if(x, ~ !is.null(.), fun, ...)
}

#' Import pipe operator from magrittr
#'
#' @importFrom magrittr %>%
#' @noRd
#'
empty <- function() NULL # NULL used to be enough, but now roxygen complains about missing @title
