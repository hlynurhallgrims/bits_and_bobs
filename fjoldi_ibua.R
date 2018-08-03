library(tidyverse)
fjoldi <- read_csv2(file = "C:/wd/fjoldi_ibua.csv", trim_ws = TRUE, skip = 2,
                    locale = locale(encoding = "ISO-8859-1"), na = "-")

fjoldi
raun_fjoldi <- sum(fjoldi$`2017 Alls`, na.rm = TRUE)

stor <- c("Reykjavík", "Kópavogur", "Hafnarfjörður", "Garðabær", "Mosfellsbær", "Seltjarnarnes", "Álftanes", "Kjósarhreppur")
plus <- c("Reykjanesbær", "Sveitarfélagið Árborg", "Hveragerði", "Grindavíkurbær", "Sandgerði", "Sveitarfélagið Garður",
          "Sveitarfélagið Vogar", "Sveitarfélagið Ölfus")

p50 <- c("Reykjavík", "Kópavogur", "Garðabær")

fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarfélag`) %>%
  filter(svfe %in% stor | svfe %in% plus) %>%
  arrange(desc(n)) %>%
  mutate(cumul_hlutfall = cumsum(n) / raun_fjoldi)

fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarfélag`) %>%
  filter(svfe %in% p50) %>%
  arrange(desc(n)) %>%
  mutate(cumul_hlutfall = cumsum(n) / raun_fjoldi)





fjoldi %>%
  select(-Aldur) %>%
  rename(n = `2017 Alls`,
         svfe = `Sveitarfélag`) %>%
  filter() %>%
  arrange(desc(n)) %>%
  mutate(hlutfall = cumsum(n) / raun_fjoldi)


x <- fjoldi %>% arrange(desc(`2017 Alls`))
as.data.frame(x)


