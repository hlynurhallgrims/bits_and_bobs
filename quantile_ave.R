quant_n <- 10 # 10 for decile, 4 for quartile, et cetera.

# Function for computing mean within each part of the n-tile
quantile_ave <- function(x, y = quant_n){
    z <- 1 / y
    q = quantile(x, seq(0, 1, by = z))
    cuts = cut(x, q)
    values_per_quantile = split(x, cuts)
    calc_mean = sapply(values_per_quantile, mean)
    names(calc_mean) <- NULL
    calc_mean
}
