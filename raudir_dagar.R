library(tidyverse)
library(timeDate)


i = 2018 #Ártal, breytið
# Hér eru frídagar sem breytast ekki á milli ára. Það er, alltaf sama dagsetning innan árs
fastir_fridagar <- tibble("fri_allan_dag" = c(1, 1, 1, 0, 1, 1, 0),
                          "fri_halfan_dag" = c(0, 0, 0, 1, 0, 0, 1),
                          "man"   = c("01",
                                      "05",
                                      "06",
                                      "12",
                                      "12",
                                      "12",
                                      "12"),
                          "dagur" = c("01",
                                      "01",
                                      "17",
                                      "24",
                                      "25",
                                      "26",
                                      "31"),
                          "skyring" = c("Nýársdagur",
                                        "Frídagur verkalýðsins",
                                        "Þjóðhátíðardagur Íslendinga",
                                        "Aðfangadagur",
                                        "Jóladagur",
                                        "Annar í jólum",
                                        "Gamlársdagur"),
                          "storhatidardagur" = c(1, 0, 1, 1, 1, 0, 1)) %>%
  mutate(dagsetning = as.Date(str_c(as.character(i), man, dagur, sep = "-"))) %>%
  select(-man, -dagur) %>%
  select(dagsetning, everything())

#Hér eru frídagar sem breytast milli ára
breytilegir_fridagar <-
  tibble("dagsetning" = c(as.Date(timeDate::GoodFriday(i) - 1), #Skírdagur
                          as.Date(timeDate::GoodFriday(i)), #Föstudagurinn langi
                          as.Date(timeDate::EasterSunday(i)), #Páskadagur
                          as.Date(timeDate::EasterMonday(i)), #Annar í páskum
                          as.Date(timeDate::timeNthNdayInMonth( #Sumardagurinn fyrsti
                            charvec = timeSequence(from = str_c(as.character(i), "04-18", sep = "-"),
                                                   to = str_c(as.character(i), "04-25", sep = "-"),
                                                   by = "days"),
                            nday = 4, nth = 1, format = "%Y-%m-%d"))[[1]], #4 er fimmtudagur hér (villandi)
                          as.Date(timeDate::Ascension(i)), #Uppstigningardagur
                          as.Date(timeDate::Pentecost(i)), #Hvítasunnudagur
                          as.Date(timeDate::PentecostMonday(i)), #Annar í hvítasunnu
                          as.Date(timeDate::timeNthNdayInMonth( #Frídagur verslunarmanna
                            charvec = timeSequence(from = str_c(as.character(i), "08-01", sep = "-"),
                                                   to = str_c(as.character(i), "08-31", sep = "-"),
                                                   by = "days"),
                            nday = 1, nth = 1, format = "%Y-%m-%d"))[[1]]), #1 er mánudagur hér (villandi)
         "fri_allan_dag" = 1,
         "fri_halfan_dag" = 0,
         "skyring" = c("Skírdagur",
                       "Föstudagurinn langi",
                       "Páskadagur",
                       "Annar í páskum",
                       "Sumardagurinn fyrsti",
                       "Uppstigningardagur",
                       "Hvítasunnudagur",
                       "Annar í Hvítasunnu",
                       "Frídagur Verzlunarmanna"),
         "storhatidardagur" = c(0, 1, 1, 0, 0, 0, 1, 0, 0))

raudir_dagar_allt <- bind_rows(fastir_fridagar, breytilegir_fridagar) %>% arrange(dagsetning)

#Hér er tómur rammi fyrir árið sem um ræðir
tomt_ar <- tibble("dagsetning" = seq(as.Date(str_c(i, "-01-01", sep = "-")),
                                     as.Date(str_c(i, "-12-31", sep = "-"), by = "days")),
                  "fri_allan_dag" = 0,
                  "fri_halfan_dag" = 0,
                  "skyring" = "",
                  "storhatidardagur" = 0)

