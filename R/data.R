#' random data for testing the functions
#' data frame with no missing values
#' @export


df.full <- data.frame(matrix(ncol=51, nrow=100))
colnames(df.full) <- c('id', c(paste0("sgrq.", 1:8), 
                               paste0("sgrq.11", letters[1:7]), 
                               paste0("sgrq.15", letters[1:9]),
                               'sgrq.9', 'sgrq.10',
                               paste0("sgrq.12", letters[1:6]), paste0("sgrq.13", letters[1:8]),
                               paste0("sgrq.14", letters[1:4]), 
                               paste0("sgrq.16", letters[1:5]), 'sgrq.17'))
df.full$id <- as.character(c(1:100))

for (i in 2:8){
  df.full[i] = round(runif(100, min = 1, max = 5))
}

for (i in c(9, 12:50)){
  df.full[i] = round(runif(100, min = 0, max = 1))
}

df.full[10] <- round(runif(100, min = 1, max = 3))
df.full[11] <- round(runif(100, min = 0, max = 2))
df.full[51] <- round(runif(100, min = 0, max = 3))

df.full[1, 2:8] <- 1

#' data frame with missing values
#' @export
df.na <- df.full
for (i in 2:ncol(df.na)){
df.na[sample(2:nrow(df.na), 10), i] <- NA
}
rm(i)

#' Regression weights for SGRQ items
#'
#' A data frame containing the regression weights for SGRQ items
#'
#' @format A data frame with 51 variables (id, sgrq.1 -- sgrq.17) and six rows
"reg.weights"
