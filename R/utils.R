#' Find set (= unique values) from a string-list of potentially several vectors
#'
#' Takes a character vectors whose elements are a list of values with a fixed separator, removes
#' duplicates, and returns a single character scalar with the same separator.
#'
#' @param x character, potentially a vector
#' @param sep character, separator. Default: \code{","}.
#'
#' @return a scaler character.
#'
#' @importFrom magrittr %>%
#' 
find_unique_set <- function(x, sep = ", ") {
	split_list_compiled <- compiler::compfun(split_list)
	paste(x, collapse = ", ") %>% # only matters if x is a vector
		purrr::map(split_list_compiled, sep = sep) %>% 
		sapply(function(x) paste(sort(unique(x)), collapse = sep))
}

# ====

#' Title
#'
#' @param x 
#' @inheritParams find_unique_set
#'
#' @return
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
#' @return
#'
#' @export

map_valid <- function(x, fun, ...) {
	purrr::map_if(x, ~ !is.null(.), fun, ...)
}
