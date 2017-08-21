#' sum function to limit number of vars with missing values
#' @export
sum.n   <- function(df, n) {
  rsum <- apply(as.matrix(df), 1, sum, na.rm = TRUE)
  nvalid <- apply(as.matrix(df), 1, function(df) sum(!is.na(df)))
  ifelse(nvalid >= n, rsum, NA)
}
