#This is a tidyverse approach to a 'read and write many' scenario posted by Mike Spencer on his website:
# https://scottishsnow.wordpress.com/2018/02/18/dplyr-lapply-for-loop/


library(tidyverse)
# Dummy files to process
dir.create("./temp/raw", recursive=T)
dir.create("./temp/clean")

timabil <- 1950:2017

timabil %>% 
  map(~data_frame(date = seq.Date(as.Date(paste0(.x, "-01-01")),
                                 as.Date(paste0(.x, "-12-31")),
                                 by=1))) %>% 
  map(~mutate(., a = rnorm(length(.$date)),
                 a1 = rnorm(length(.$date)),
                 a2 = rnorm(length(.$date)),
                 b = rpois(length(.$date), 10),
                 b1 = rpois(length(.$date), 10),
                 b2 = rpois(length(.$date), 10),
                 c = rexp(length(.$date), 5),
                 c1 = rexp(length(.$date), 5),
                 c2 = rexp(length(.$date), 5))) %>% 
  walk2(.y = timabil, ~write_csv(x = .x, path = paste0("temp/raw/file_", .y, ".csv")))


skjalanofn = list.files("./temp/raw", pattern="file")

df_list <- map(.x = skjalanofn, .f = ~read_csv(here::here("temp", "raw", .x)))
names(df_list) <- skjalanofn

df_list %>% 
  map(~select(., date, a, b, c)) %>%
  walk2(.y = names(.), ~write_csv(x = .x, path = here::here("temp", "clean", .y)))
