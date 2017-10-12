# Function for computing mean within each part of the n-tile
quantile_ave <- function(x, n = 10){
    z <- 1 / n
    q = quantile(x, seq(0, 1, by = z))
    cuts = cut(x, q)
    values_per_quantile = split(x, cuts)
    calc_mean = sapply(values_per_quantile, mean)
    names(calc_mean) <- NULL
    calc_mean
}
