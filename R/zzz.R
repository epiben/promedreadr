.onLoad <- function(libname = find.package("promedreadr"), pkgname = "promedreadr") {
	if (getRversion() >= "2.15.1") {
		utils::globalVariables(c(
			# promedreadr-specific variables
			"X1", "X2", "ades", "frequency", "sleep_time"
		)) # see: https://stackoverflow.com/a/12429344
	}
}