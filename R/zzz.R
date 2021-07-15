#' Find set (= unique values) from a string-list of potentially several vectors
#'
#' Takes a character vectors whose elements are a list of values with a fixed separator, removes
#' duplicates, and returns a single character scalar with the same separator.
#'
#' @param x character, potentially a vector
#' @param sep character, separator. Default: \code{", "}.
#'
#' @return a scaler character.
#'
#' @importFrom magrittr %>%

find_unique_set <- function(x, sep = ", ") {
	paste(x, collapse = ", ") %>% # only matters if x is a vector
		stringr::str_split(sep) %>%
		sapply(function(x) paste(sort(unique(x)), collapse = sep))
}

# ====

#' map non-null list elements with function
#'
#' @param x list whose elements should be mapped, except for NULL elements
#' @param fun function to apply
#'
#' @return
#'
#' @export

map_valid <- function(x, fun, ...) {
	purrr::map_if(x, ~ !is.null(.), fun, ...)
}

# ===

.onLoad <- function(libname = find.package("promedreadr"), pkgname = "promedreadr") {
	if (getRversion() >= "2.15.1") {
		utils::globalVariables(c(
			# promedreadr-specific variables
			"X1", "X2", "ades", "frequency"
		)) # see: https://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when
	}
}