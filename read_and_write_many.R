#This is a tidyverse approach to a 'read and write many' scenario posted by Mike Spencer on his website:
# https://scottishsnow.wordpress.com/2018/02/18/dplyr-lapply-for-loop/

library(tidyverse)
library(glue)
library(here)

# Dummy files to process
dir.create("./temp/raw", recursive=T)
dir.create("./temp/clean")

timespan <- 1950:2017

#TIDYVERSE... ASSEMBLE!!!
#To create the dummy data using purrr
timespan %>% 
  map(~data_frame(date = seq.Date(as.Date(glue("{.x}-01-01")),
                                  as.Date(glue("{.x}-12-31")),
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
  walk2(.y = timespan, ~write_csv(x = .x, path = glue("temp/raw/file_{.y}.csv")))

all_files <- list.files("./temp/raw", pattern="file")

#To select, gather and then write the new data to multiple .CSVs
df_list <- map(.x = all_files, .f = ~read_csv(here::here("temp", "raw", .x)))
names(df_list) <- all_files

df_list %>% 
  map(~select(., date, a, b, c)) %>%
  map(~gather(., variable, value, -date)) %>%
  walk2(.y = names(.), ~write_csv(x = .x, path = here::here("temp", "clean", .y)))
