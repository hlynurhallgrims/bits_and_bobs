library(tidyverse)
library(timeDate)


i = 2018 #�rtal, breyti�
# H�r eru fr�dagar sem breytast ekki � milli �ra. �a� er, alltaf sama dagsetning innan �rs
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
                          "skyring" = c("N��rsdagur",
                                        "Fr�dagur verkal��sins",
                                        "�j��h�t��ardagur �slendinga",
                                        "A�fangadagur",
                                        "J�ladagur",
                                        "Annar � j�lum",
                                        "Gaml�rsdagur"),
                          "storhatidardagur" = c(1, 0, 1, 1, 1, 0, 1)) %>%
  mutate(dagsetning = as.Date(str_c(as.character(i), man, dagur, sep = "-"))) %>%
  select(-man, -dagur) %>%
  select(dagsetning, everything())

#H�r eru fr�dagar sem breytast milli �ra
breytilegir_fridagar <-
  tibble("dagsetning" = c(as.Date(timeDate::GoodFriday(i) - 1), #Sk�rdagur
                          as.Date(timeDate::GoodFriday(i)), #F�studagurinn langi
                          as.Date(timeDate::EasterSunday(i)), #P�skadagur
                          as.Date(timeDate::EasterMonday(i)), #Annar � p�skum
                          as.Date(timeDate::timeNthNdayInMonth( #Sumardagurinn fyrsti
                            charvec = timeSequence(from = str_c(as.character(i), "04-18", sep = "-"),
                                                   to = str_c(as.character(i), "04-25", sep = "-"),
                                                   by = "days"),
                            nday = 4, nth = 1, format = "%Y-%m-%d"))[[1]], #4 er fimmtudagur h�r (villandi)
                          as.Date(timeDate::Ascension(i)), #Uppstigningardagur
                          as.Date(timeDate::Pentecost(i)), #Hv�tasunnudagur
                          as.Date(timeDate::PentecostMonday(i)), #Annar � hv�tasunnu
                          as.Date(timeDate::timeNthNdayInMonth( #Fr�dagur verslunarmanna
                            charvec = timeSequence(from = str_c(as.character(i), "08-01", sep = "-"),
                                                   to = str_c(as.character(i), "08-31", sep = "-"),
                                                   by = "days"),
                            nday = 1, nth = 1, format = "%Y-%m-%d"))[[1]]), #1 er m�nudagur h�r (villandi)
         "fri_allan_dag" = 1,
         "fri_halfan_dag" = 0,
         "skyring" = c("Sk�rdagur",
                       "F�studagurinn langi",
                       "P�skadagur",
                       "Annar � p�skum",
                       "Sumardagurinn fyrsti",
                       "Uppstigningardagur",
                       "Hv�tasunnudagur",
                       "Annar � Hv�tasunnu",
                       "Fr�dagur Verzlunarmanna"),
         "storhatidardagur" = c(0, 1, 1, 0, 0, 0, 1, 0, 0))

raudir_dagar_allt <- bind_rows(fastir_fridagar, breytilegir_fridagar) %>% arrange(dagsetning)

#H�r er t�mur rammi fyrir �ri� sem um r��ir
tomt_ar <- tibble("dagsetning" = seq(as.Date(str_c(i, "-01-01", sep = "-")),
                                     as.Date(str_c(i, "-12-31", sep = "-"), by = "days")),
                  "fri_allan_dag" = 0,
                  "fri_halfan_dag" = 0,
                  "skyring" = "",
                  "storhatidardagur" = 0)

