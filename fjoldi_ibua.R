library(tidyverse)
fjoldi <- read_csv2(file = "C:/wd/fjoldi_ibua.csv", trim_ws = TRUE, skip = 2,
                    locale = locale(encoding = "ISO-8859-1"), na = "-")

fjoldi
raun_fjoldi <- sum(fjoldi$`2017 Alls`, na.rm = TRUE)

stor <- c("Reykjav�k", "K�pavogur", "Hafnarfj�r�ur", "Gar�ab�r", "Mosfellsb�r", "Seltjarnarnes", "�lftanes", "Kj�sarhreppur")
plus <- c("Reykjanesb�r", "Sveitarf�lagi� �rborg", "Hverager�i", "Grindav�kurb�r", "Sandger�i", "Sveitarf�lagi� Gar�ur",
          "Sveitarf�lagi� Vogar", "Sveitarf�lagi� �lfus")

p50 <- c("Reykjav�k", "K�pavogur", "Gar�ab�r")

fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarf�lag`) %>%
  filter(svfe %in% stor | svfe %in% plus) %>%
  arrange(desc(n)) %>%
  mutate(cumul_hlutfall = cumsum(n) / raun_fjoldi)

fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarf�lag`) %>%
  filter(svfe %in% p50) %>%
  arrange(desc(n)) %>%
  mutate(cumul_hlutfall = cumsum(n) / raun_fjoldi)





fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarf�lag`) %>%
  filter() %>%
  arrange(desc(n)) %>%
  mutate(hlutfall = cumsum(n) / raun_fjoldi)


x <- fjoldi %>% arrange(desc(`2017 Alls`))
as.data.frame(x)


