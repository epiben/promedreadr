#' Set up the remote driver and open
#'
#' @param browser string, which browser to use. Default is \code{"firefox"}.
#' @param ... arguments passed to \code{rsDriver()}
#'
#' @return Driver object that can navigate to desired URLs

create_remote_driver <- function(browser = "firefox", ...) {
	rD <- RSelenium::rsDriver(browser = browser, ...)
	return(rD[["client"]])
}
