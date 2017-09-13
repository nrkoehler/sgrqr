#' random data for testing the functions
#' data frame with no missing values
#' @export


sgrq.full <- data.frame(matrix(ncol=51, nrow=100))
colnames(sgrq.full) <- c('id', c(paste0("sgrq.", 1:8), 
                               paste0("sgrq.11", letters[1:7]), 
                               paste0("sgrq.15", letters[1:9]),
                               'sgrq.9', 'sgrq.10',
                               paste0("sgrq.12", letters[1:6]), paste0("sgrq.13", letters[1:8]),
                               paste0("sgrq.14", letters[1:4]), 
                               paste0("sgrq.16", letters[1:5]), 'sgrq.17'))
sgrq.full$id <- as.character(c(1:100))


for (i in c(2:8)){
  sgrq.full[i] = round(runif(100, min = 1, max = 5))
}

for (i in c(9:25, 28:50)){
  sgrq.full[i] = round(runif(100, min = 0, max = 1))
}

sgrq.full[26] <- round(runif(100, min = 0, max = 3))
sgrq.full[27] <- round(runif(100, min = 0, max = 2))
sgrq.full[51] <- round(runif(100, min = 0, max = 3))
sgrq.full[1, 2:8] <- 1

#' data frame with missing values
#' @export
sgrq.na <- sgrq.full
for (i in 2:ncol(sgrq.na)){
sgrq.na[sample(2:nrow(sgrq.na), 10), i] <- NA
}
rm(i)

#' Regression weights for SGRQ items
#'
#' A data frame containing the regression weights for SGRQ items
#'
#' @format A data frame with 51 variables (id, sgrq.1 -- sgrq.17) and six rows
"reg.weights"
