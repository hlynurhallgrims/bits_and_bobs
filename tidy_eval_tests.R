library(tidyverse)
library(rlang)

df <- tribble(
  ~year,  ~proj_ann_growth, ~cost,
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


# Test 2
project_by <- function(data, x, by) {
  col_upon <- enquo(x)
  col_from <- enquo(by)

  replacement <- vector(length = nrow(data))
  
  for (i in 2:nrow(data)) {
    if (!(is.na(eval_tidy(col_upon, data)[i - 1]))) {
      replacement[[i]] <- eval_tidy(col_upon, data)[i - 1] * (1 + eval_tidy(col_from, data)[i])
    } else {
      replacement[[i]] <- replacement[[i - 1]] * (1 + eval_tidy(col_from, data)[i])
    }
  }
  nafn <- sym(paste0("proj_", quo_text(col_upon)))
  data <- data %>% 
    mutate(!! nafn := as.numeric(!!col_upon),
           !! nafn := coalesce(!!col_upon, replacement))

  data
}

df %>% 
  project_by(cost, proj_ann_growth)
