library(tidyverse)
library(rlang)

df <- tribble(
  ~year,  ~proj_ann_growth, ~actual_cost,
  2014,  0.110,          200, 
  2015,  0.111,          221, 
  2016,  0.079,          244, 
  2017,  0.087,          268, 
  2018,  0.095,          NA, 
  2019,  0.102,          NA, 
  2020,  0.101,          NA, 
  2021,  0.107,          NA, 
  2022,  0.091,          NA, 
  2023,  0.108,          NA,
  2024,  0.119,          NA,
  2025,  0.121,          NA)


# Test 1
valmynd <- function(data, x) {
  x <- enquo(x)
  select(data, !!x)[[1]]
}

valmynd(df, actual_cost)

# Test 2
project_by <- function(data, x, by) {
  
  col_upon <- enquo(x)
  col_from <- enquo(by)
  
  new_df <- select(data, !!col_from, !!col_upon)
  old_names <- names(new_df)
  names(new_df) <- c("col_from", "col_upon")
  replacement <- vector(length = nrow(data))
  
  for (i in 2:nrow(new_df)) {
    if (!(is.na(new_df$col_upon[i - 1]))) {
      replacement[[i]] <- new_df$col_upon[i - 1] * (1 + new_df$col_from[i])
    } else {
      replacement[[i]] <- replacement[[i - 1]] * (1 + new_df$col_from[i])
    }
  }
  new_df <- new_df %>% 
    mutate(col_upon = as.numeric(col_upon),
           col_upon = coalesce(col_upon, replacement))
  names(new_df) <- old_names
  data <- data[setdiff(names(data), names(new_df))]
  new_df <- bind_cols(data, new_df)
  new_df
}

df %>% 
  project_by(actual_cost, proj_ann_growth)
