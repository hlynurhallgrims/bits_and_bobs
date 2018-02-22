library(tidyverse)
library(here)

f <- list.files("./temp/raw", pattern="file")

map(.x = f, .f = ~read_csv(here::here("temp", "raw", .x))) %>% 
  map(~select(., date, a, b, c)) %>%
  map(~gather(., variable, value, -date)) %>%
  walk2(.y = f, ~write_csv(x = .x, path = here::here("temp", "clean", .y)))
