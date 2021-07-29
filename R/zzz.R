.onLoad <- function(libname = find.package("promedreadr"), pkgname = "promedreadr") {
	if (getRversion() >= "2.15.1") {
		utils::globalVariables(c(
			# promedreadr-specific variables
			"X1", "X2", "side_effects", "frequency", "sleep_time",
			
			# dplyr functions
			"group_by", "summarise"
		)) # see: https://stackoverflow.com/a/12429344
	}
}