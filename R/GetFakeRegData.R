#' Provide dataframe of fake registry data
#'
#' Provides a dataframe containing built-in data (and not a registry) for demo
#' purposes
#'
#' @return regData data frame
#' @export

getFakeRegData <- function() {
  # Try to get internal dataset from package namespace
  if (exists("cases_year", envir = asNamespace("rapRegTemplate"), inherits = FALSE)) {
    getFromNamespace("cases_year", "rapRegTemplate")
  } else if (exists("cases_year", envir = .GlobalEnv, inherits = FALSE)) {
    # Fallback if user has loaded the data into the global env
    get("cases_year", envir = .GlobalEnv)
  } else {
    warning("Internal data 'cases_year' not found. Returning empty data frame.\n",
            "If you want the example data, run data-raw/internalData.R and use usethis::use_data(..., internal = TRUE) or ensure the package data is installed.")
    if (requireNamespace("tibble", quietly = TRUE)) {
      tibble::tibble()
    } else {
      data.frame()
    }
  }
}
