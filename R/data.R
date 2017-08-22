#' random data for testing the functions
#' data frame with no missing values
#' @export


df.full <- data.frame(matrix(ncol=51, nrow=100))
colnames(df.full) <- c('id', paste0('sgrq.', seq(1, 50, 1)))
df.full$id <- as.character(c(1:100))
df.full[1, 2:10] <- 1
df.full[1, 11] <- 2
df.full[1, 12:50] <- 1
df.full[1, 51] <- 3


for (i in 2:8){
  df.full[i] = round(runif(100, min = 1, max = 5))
}

for (i in c(9, 12:50)){
  df.full[i] = round(runif(100, min = 0, max = 1))
}

df.full[10] <- round(runif(100, min = 1, max = 3))
df.full[11] <- round(runif(100, min = 0, max = 2))
df.full[51] <- round(runif(100, min = 0, max = 3))


#' data frame with missing values
#' @export
df.na <- df.full
for (i in 2:ncol(df.na)){
df.na[sample(2:nrow(df.na), 10), i] <- NA
}

#' Regression weights for SGRQ items
#'
#' A data frame containing the regression weights for SGRQ items
#'
#' @format A data frame with 51 variables (id, sgrq.1 -- sgrq.50) and six rows
"reg.weights"
