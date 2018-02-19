library(tidyverse)
library(here)

df_list <- map(.x = f, .f = ~read_csv(here::here("temp", "raw", .x)))
names(df_list) <- f

df_list %>% 
  map(~select(., date, a, b, c)) %>%
  walk2(.y = names(.), ~write_csv(x = .x, path = here::here("temp", "clean", .y)))
