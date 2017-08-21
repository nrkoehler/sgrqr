#' Severe Respiratory Insufficiency Questionnaire (SRI)
#'
#' SGRQ scoring
#' @param X a \code{\link{matrix}} or \code{\link{data.frame}} of 50
#' columns, containing the questionnaire items. In order from left to right:
#' sgrq.1 -- sgrq.50.
#'
#' @export
scoring_sgrq <- function( X, id = '') {


# STEP 1: INPUT DATA ------------------------------------------------------


  items = paste0("sgrq.", 1:50)
  if (length(which(is.element(items, colnames(X)))) < 50) {
    stop("At least one item is missing: items must be named sgrq.1 to sgrq.50")
    break
  }
  if (length(which(match(items, colnames(X)) == sort(match(items,
                                                           colnames(X))))) < 50) {
    stop("Items must be named sgrq.1 to sgrq.50 and presented on that order in the dataset")
    break
  }
  if (sum(apply(X[, items], 2, is.numeric)) < 50) {
    stop("Items must be numeric")
    break
  }
  if (min(X[, items], na.rm = T) < 0) {
    stop("Minimum possible value for items is 0")
    break
  }
  if (max(X[, items[1:50]], na.rm = T) > 5) {
    stop("Maximum possible value for items is 5")
    break
  }



# RECODE DATA -------------------------------------------------------------



  for (j in 1:ncol(reg.weights)){
    for (k in 1:nrow(X)){
      X[k, j+1] <- unlist(ifelse(X[k, j+1] == 0, reg.weights[1, j],
                                    ifelse(X[k, j+1] == 1, reg.weights[2, j],
                                           ifelse(X[k, j+1] == 2, reg.weights[3, j],
                                                  ifelse(X[k, j+1] == 3, reg.weights[4, j],
                                                         ifelse(X[k, j+1] == 4, reg.weights[5, j],
                                                                ifelse(X[k, j+1] == 5, reg.weights[6, j], NA)))))))
    }

  }

# STEP 3: SGRQ SCALE CONSTRUCTION -----------------------------------------

  ##############################
  ## Symptoms Score (8 items) ##
  ##############################

  repl.val <- vector('numeric', 8)
  for (i in 1:8){
    repl.val[i] = max(reg.weights[i], na.rm = TRUE)
  }
  a <- which(names(X)=="sgrq.1");   z <- which(names(X)=="sgrq.8")
  # define variable names
  sgrq.ss <- paste0("sgrq.", 1:8)
  # calculate number of missing items
  X$NMISS.ss <- rowSums(is.na(X[, c(a:z)]))
  # replace missing values with highest score
  for (i in a:z) {
    for (j in 1:nrow(X)){
      X[j, i] <- ifelse(is.na(X[j, i] == TRUE), repl.val[i-1], X[j, i])
    }}
  # calculate score
  X$sgrq.ss <- rowSums(X[, paste0("sgrq.", 1:8)]) / 662.5 * 100
  X$sgrq.ss <- round(X$sgrq.ss, 1)
  X$sgrq.ss <- ifelse(X$NMISS.ss > 2, NA, X$sgrq.ss)
  comment(X$sgrq.ss) <- "SGRQ - Symptoms Score (0-100)"

  ###############################
  ## Activity Score (16 items) ##
  ###############################

  repl.val <- vector('numeric', 16)
  for (i in 9:24){
    repl.val[i-8] = max(reg.weights[i], na.rm = TRUE)
  }
  a <- which(names(X)=="sgrq.9");   z <- which(names(X)=="sgrq.24")
  # define variable names
  sgrq.as <- paste0("sgrq.", 9:24)
  # calculate number of missing items
  X$NMISS.as <- rowSums(is.na(X[, c(a:z)]))
  # replace missing values with highest score
  for (i in a:z) {
    for (j in 1:nrow(X)){
      X[j, i] <- ifelse(is.na(X[j, i] == TRUE), repl.val[i-9], X[j, i])
    }}
  # calculate score
  X$sgrq.as <- rowSums(X[, paste0("sgrq.", 9:24)]) / 1209.1 * 100
  X$sgrq.as <- round(X$sgrq.as, 1)
  X$sgrq.as <- ifelse(X$NMISS.as > 4, NA, X$sgrq.as)
  comment(X$sgrq.as) <- "SGRQ - Activity Score (0-100)"


  ##############################
  ## Impacts Score (26 items) ##
  ##############################

  repl.val <- vector('numeric', 26)
  for (i in 25:50){
    repl.val[i-24] = max(reg.weights[i], na.rm = TRUE)
  }
  a <- which(names(X)=="sgrq.25");   z <- which(names(X)=="sgrq.50")
  # define variable names
  sgrq.is <- paste0("sgrq.", seq(25, 50, 1))
  # calculate number of missing items
  X$NMISS.is <- rowSums(is.na(X[, c(a:z)]))
  # replace missing values with highest score
  for (i in a:z) {
    for (j in 1:nrow(X)){
      X[j, i] <- ifelse(is.na(X[j, i] == TRUE), repl.val[i-25], X[j, i])
    }}
  # calculate score
  X$sgrq.is <- rowSums(X[, paste0("sgrq.", 25:50)]) / 2117.8 * 100
  X$sgrq.is <- round(X$sgrq.is, 1)
  X$sgrq.is <- ifelse(X$NMISS.is > 6, NA, X$sgrq.is)
 # X$NMISS <- NULL
  comment(X$sgrq.is) <- "SGRQ - Impacts Score (0-100)"

  ## Total Score (50 items)
  # define variable names

  sgrq.ts <- paste0("sgrq.", seq(1, 50, 1))
  X$NMISS <- X$NMISS.ss + X$NMISS.as + X$NMISS.is
  X$sgrq.ts <- sum.n(X[, paste0("sgrq.", 1:50)], 50) / 3989.4 * 100
  X$sgrq.ts <- ifelse(X$NMISS > 12, NA, X$sgrq.ts)
  X$sgrq.ts <- round(X$sgrq.ts, 1)


# RETURN VARIABLES --------------------------------------------------------


 vars.returned <- c('id', "sgrq.ss", "sgrq.as", "sgrq.is", "sgrq.ts")

 return(X[, names(X) %in% vars.returned, drop = FALSE])

}


