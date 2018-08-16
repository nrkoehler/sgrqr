
<!-- README.md is generated from README.Rmd. Please edit that file -->
`sgrqr`
=======

### Scoring the St George's Respiratory Questionnaire

<img src="figures/sgrq-1.png" width="200" style="display: block; margin: auto auto auto 0;" />

Package Description
-------------------

With `score_sgrq` the package contains a function for scoring the [*St George's Respiratory Questionnaire*](http://www.healthstatus.sgul.ac.uk/SGRQ_download/Original%20English%20version.pdf) (SGRQ). In addition, `sgrqr` provides two simulated data frames containing the SGRQ items:

-   `sgrq.full`: Data frame with no missing values;
-   `sgrq.na`: Data frame with some missing values.

Installation
------------

``` r
devtools::install_github("nrkoehler/sgrqr")
```

Background
----------

The **St George's Respiratory Questionnaire (SGRQ)** is an instrument for the measuring of Health-Related Quality-of-Life in patients with diseases of airways obstruction. The SGRQ contains 50 items covering three domains:

-   *Symptoms* (8 items),
-   *Activity* (16 items), and
-   *Impacts* (26 items).

In addition, a total summary scale may be computed (1, 2).

All scales have a score range between 0 and 100 with higher scores indicating a worse quality of life \[2\]. The items are either scored on 3-point-, 4-point-, and 5-point Likert scales, or they are binary-choice items that must be answered with either "yes" or "no". Each item has an empirically derived regression weight.

Scoring the SGRQ
----------------

Based on the [SGRQ Scoring Manual](http://www.healthstatus.sgul.ac.uk/SGRQ_download/SGRQ%20Manual%20June%202009.pdf), I have written the `R`-package `sgrqr` for calculating the SGRQ scores.

### Installation

The package is hosted on [GitHub](https://github.com/nrkoehler/sgrqr) and may be installed using the following code:

``` r
devtools::install_github("nrkoehler/sgrqr")
library(sgrqr)
```

### Functions and data

The core of `sgrqr` is the function `scoring_sgrq()`. It must be applied to a data frame with the 50 SGRQ items and one id variable. Moreover, the package contains two data frames with simulated values. Unlike `sgrq.full`, `sgrq.na` has some missing values.

``` r
dplyr::glimpse(sgrq.na)
#> Observations: 100
#> Variables: 51
#> $ id       <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1...
#> $ sgrq.1   <dbl> 1, 3, 1, 2, 3, NA, NA, 1, 3, 4, 2, 3, 3, NA, 3, NA, 3...
#> $ sgrq.2   <dbl> 1, 2, 3, 1, 4, 4, 1, NA, 3, 2, 5, 3, NA, 4, 2, 4, NA,...
#> $ sgrq.3   <dbl> 1, 5, 4, NA, 3, 3, 4, 2, 5, 3, NA, 3, 3, 1, 2, 4, 3, ...
#> $ sgrq.4   <dbl> 1, 2, 5, 3, 1, NA, 2, 4, 4, 2, 1, 3, 4, 2, 1, 3, 1, 2...
#> $ sgrq.5   <dbl> 1, 2, 1, 3, NA, 1, 4, 1, 5, 3, 2, 4, 5, 3, 4, 2, NA, ...
#> $ sgrq.6   <dbl> 1, NA, 2, 4, 4, 4, 2, 5, 2, 4, 4, 4, 2, 3, NA, 4, 2, ...
#> $ sgrq.7   <dbl> 1, 2, NA, 4, 1, NA, 2, 4, 4, 2, 4, 5, 3, NA, 5, 5, 3,...
#> $ sgrq.8   <dbl> 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1,...
#> $ sgrq.11a <dbl> 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0,...
#> $ sgrq.11b <dbl> 0, 1, NA, 0, 0, 0, NA, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, ...
#> $ sgrq.11c <dbl> 0, 0, 1, 1, 0, 0, NA, 0, 0, NA, 1, 1, 1, 0, 0, 1, NA,...
#> $ sgrq.11d <dbl> 1, 0, 0, 1, NA, NA, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, ...
#> $ sgrq.11e <dbl> 1, NA, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0...
#> $ sgrq.11f <dbl> 0, 1, 1, 1, 1, 1, 0, 1, NA, 1, 0, 1, 0, 0, 0, 1, 0, 0...
#> $ sgrq.11g <dbl> 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0,...
#> $ sgrq.15a <dbl> 0, 1, NA, 1, 1, 1, 0, 0, 0, 0, NA, 1, 0, 0, 1, 1, 1, ...
#> $ sgrq.15b <dbl> 0, 1, NA, 0, 0, NA, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, ...
#> $ sgrq.15c <dbl> 0, 1, 1, 0, 0, 0, NA, 1, 0, 0, 1, 0, 1, NA, 0, 1, 0, ...
#> $ sgrq.15d <dbl> 1, 1, 0, 0, 0, NA, 0, 0, 1, NA, 1, 0, 1, 1, 1, 0, 1, ...
#> $ sgrq.15e <dbl> 0, NA, 1, 1, 0, 0, 1, NA, 0, 0, 0, 0, 0, 0, 0, 1, 1, ...
#> $ sgrq.15f <dbl> 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, NA, 1, 1, 1, 1, 0, 0...
#> $ sgrq.15g <dbl> 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, NA, 0...
#> $ sgrq.15h <dbl> 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, NA, N...
#> $ sgrq.15i <dbl> 1, 0, 0, 0, 1, 0, 0, 1, NA, NA, 0, 1, 1, 0, 1, 0, 1, ...
#> $ sgrq.9   <dbl> 0, 2, 2, 1, NA, 3, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0, 2...
#> $ sgrq.10  <dbl> 1, 0, 1, 1, 2, 1, 1, 0, 1, 2, 0, 1, 1, 1, 1, 1, 1, 1,...
#> $ sgrq.12a <dbl> 1, 0, 0, NA, 0, 0, 0, 1, 0, NA, 0, 1, 0, 1, 0, 1, 0, ...
#> $ sgrq.12b <dbl> 1, 1, 1, NA, 0, 0, 0, 0, 0, 1, 1, 1, NA, NA, 1, 1, 0,...
#> $ sgrq.12c <dbl> 0, 1, 0, 0, NA, 1, 1, 0, 0, NA, 0, 1, 0, NA, 1, 1, 1,...
#> $ sgrq.12d <dbl> 1, 0, 0, 1, NA, NA, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, ...
#> $ sgrq.12e <dbl> 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0,...
#> $ sgrq.12f <dbl> 1, 0, 0, NA, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, NA, ...
#> $ sgrq.13a <dbl> 0, 1, 1, NA, 1, 1, 0, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, ...
#> $ sgrq.13b <dbl> 1, 1, 1, 1, 0, 1, 0, 0, NA, 0, 1, 1, 1, 1, 1, NA, 1, ...
#> $ sgrq.13c <dbl> 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1,...
#> $ sgrq.13d <dbl> 1, 1, 0, 0, 1, NA, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, N...
#> $ sgrq.13e <dbl> 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, NA, 0, 0, 0, 1, 0, 1, 1...
#> $ sgrq.13f <dbl> 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1,...
#> $ sgrq.13g <dbl> 0, 1, 0, 1, NA, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0...
#> $ sgrq.13h <dbl> 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1,...
#> $ sgrq.14a <dbl> 0, 0, 0, 0, 0, 1, 1, 0, 0, NA, 1, 1, 1, 0, 1, 1, 1, 1...
#> $ sgrq.14b <dbl> 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0,...
#> $ sgrq.14c <dbl> 0, 0, 1, 0, 1, NA, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, N...
#> $ sgrq.14d <dbl> 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, NA, 1, 0, 0, 0, 0, 1, 0...
#> $ sgrq.16a <dbl> 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, NA, 1...
#> $ sgrq.16b <dbl> 1, 0, 0, 1, 0, NA, NA, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, ...
#> $ sgrq.16c <dbl> 1, 0, 0, 0, 1, 0, NA, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1...
#> $ sgrq.16d <dbl> 1, NA, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1...
#> $ sgrq.16e <dbl> 1, 0, NA, 1, 1, 0, NA, 0, NA, 0, 1, NA, 0, 1, 0, 0, 0...
#> $ sgrq.17  <dbl> 1, NA, 1, 3, 1, 0, 1, 3, 2, 1, 1, 3, 0, 0, 3, 0, NA, ...
```

### Usage

When applied to a data frame, the function returns a data frame containing the SGRQ score values and an id variable.

``` r
df <- scoring_sgrq(sgrq.full, id = 'id')
head(df)
#>   id sgrq.ss sgrq.as sgrq.is sgrq.ts
#> 1  1    90.6    30.3    62.8    57.6
#> 2  2    62.5    75.4    37.3    53.1
#> 3  3    58.4    61.5    47.9    53.8
#> 4  4    61.7    51.4    46.2    50.4
#> 5  5    67.5    49.4    59.9    58.0
#> 6  6    59.8    50.5    52.6    53.2
```

If no id variable is specified, a data frame containing the score values only is returned.

``` r
df <- scoring_sgrq(sgrq.na)
head(df)
#>   sgrq.ss sgrq.as sgrq.is sgrq.ts
#> 1    90.6    30.3    62.8    57.6
#> 2    69.8    75.4    41.7    56.6
#> 3    61.0    68.4    47.9    56.3
#> 4    68.3    51.4    53.8    55.5
#> 5    71.4    56.2    67.5    64.7
#> 6      NA    57.2    56.4    58.9
```

### Difficulties in handling missing values

In the SGRQ scoring manual it says:

> The Symptoms component will tolerate a maximum of 2 missed items. The weight for the missed item is subtracted from the total possible weight for the Symptoms component (662.5) and from the Total weight (3989.4).

Since item weights depend on the actual answers given, it remains unclear (at least for me) how to determine the weight of a missing item. The weight of the item "If you have a wheeze, is it worse in the morning?", for example, is "0.0" vs. "62.0" depending on the answer "no" vs. "yes". The algorithm implemented in `scoring_sgrq()` ascribes the missing item the highest weight possible (so 62.0 rather than 0.0). In order to be able to substract the weight of the missing item "from the total possible weight for the Symptoms component and from the Total weight", it needs to be checked whether no more than 2 items are missing, and if so, which items are missing. Since this is very extensive to implement, I decided to program the algorithm the quick and dirty way.

First, I check whether no more than 2 items are missing:

``` r
  # return position of first item 
  a <- which(names(X)=="sgrq.1")   
  # return position of last item
  z <- which(names(X)=="sgrq.8")
  # calculate number of missing items
  Y$NMISS.ss <- rowSums(is.na(X[, c(a:z)]))
```

Second, I replace *all* missing values with the corresponding highest item weight:

``` r
  # replace missing values with highest weight
  for (i in a:z) {
    for (j in 1:nrow(X)){
      X[j, i] <- ifelse(is.na(X[j, i] == TRUE), repl.val[i-1], X[j, i])
    }}
```

Third, I calculate the score:

``` r
 # calculate score
  Y$sgrq.ss <- rowSums(X[, vars]) / 662.5 * 100
```

And finally, I replace the score value by `NA` if more than 2 items of the Symptom score are missing:

``` r
 Y$sgrq.ss <- ifelse(Y$NMISS.ss > 2, NA, Y$sgrq.ss)
```

Rather than substracting the weight of the missing item "form the total possible weight", I "add" the highest possible item weight to the missing item, but only if no more than 2 items are missing.

I'm looking forward to getting some feedback to this post. I'm sure there is a better solution.

References
----------

1.  Jones, P. W., F. H. Quirk, and C. M. Baveystock. 1991. The St George Respiratory Questionnaire. *Respiratory Medicine* 85 (September): 25-31. <doi:10.1016/S0954-6111(06)80166-6>.

2.  Jones, Paul W, Frances H Quirk, Chloë M Baveystock, and Peter Littlejohns. 1992. A Self-Complete Measure of Health Status for Chronic Airflow Limitation. *Am Rev Respir Dis* 145 (6): 1321-7.
