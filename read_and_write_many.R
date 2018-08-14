library(tidyverse)
library(glue)
library(here)

# Dummy folders to process
dir.create("./temp/raw", recursive = T)
dir.create("./temp/clean")

timespan <- 1950:2017

#TIDYVERSE... ASSEMBLE!!!
#Dummy data created and written to multiple .CSVs
timespan %>%
  map(~data_frame(date = seq.Date(as.Date(glue("{.x}-01-01")),
                                  as.Date(glue("{.x}-12-31")),
                                  by=1))) %>%
  map(~mutate(., a  = rnorm(length(.$date)),
              a1 = rnorm(length(.$date)),
              a2 = rnorm(length(.$date)),
              b  = rpois(length(.$date), 10),
              b1 = rpois(length(.$date), 10),
              b2 = rpois(length(.$date), 10),
              c  = rexp(length(.$date), 5),
              c1 = rexp(length(.$date), 5),
              c2 = rexp(length(.$date), 5))) %>%
  walk2(.y = timespan, ~write_csv(x = .x, path = glue("temp/raw/file_{.y}.csv")))

all_files <- list.files(here::here("temp", "raw"), pattern = "file")

#The data is then manipulated to long format, then written to multiple .CSVs
df_list <- map(.x = all_files, .f = ~read_csv(here::here("temp", "raw", .x)))
names(df_list) <- all_files

df_list %>%
  map(~select(., date, a, b, c)) %>%
  map(~gather(., variable, value, -date)) %>%
  walk2(.y = names(.), ~write_csv(x = .x, path = here::here("temp", "clean", .y)))
