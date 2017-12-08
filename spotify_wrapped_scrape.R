# Load --------------------------------------------------------------------

library(rtweet)
library(tidyverse)
library(tidytext)
library(scales)
point <- format_format(big.mark = ".", decimal.mark. = ",", scientific = FALSE)

# Read --------------------------------------------------------------------

spotify_tweets <- search_tweets(
  "#2017wrapped", n = 20000, include_rts = FALSE
)

# Wrangle -----------------------------------------------------------------

id_spot <- spotify_tweets %>% 
  select(status_id, text) %>% 
  rename(texti = text)

spot_done <- id_spot %>%
  filter(str_detect(str_to_lower(texti), "minut")) %>% 
  unnest_tokens(output = bigram, input = texti, token = "ngrams", n = 2) %>% 
  separate(bigram, into = c("ord1", "ord2"), sep = " ") %>% 
  filter(str_detect(str_to_lower(ord2), "minut"),
         str_detect(ord1, "\\d")) %>% 
  rename(minutur = ord1) %>% 
  mutate(minutur = str_replace(minutur, pattern = ",", replace = ""),
         minutur = as.numeric(minutur)) %>% 
  filter(!is.na(minutur),
         minutur <= 525600) #Mínútur í ári

# Summarize

spot_done %>% 
  summarize(minutur_medaltal = round(mean(minutur), 0),
            minutur_midgildi = median(minutur))

# Visualize

spot_done %>% 
  ggplot(mapping = aes(x = minutur)) +
  geom_histogram(breaks = seq(0, 100000, by = 5000), color = "white") +
  scale_x_continuous(labels = point, limits = c(0, 100000), name = "Mínútur af Spotify hlustun á árinu") +
  ylab("Fjöldi tísta í hverju 5.000 mínútna bili") +
  ggtitle(label = "Í hve margar mínútur hlustuðu Spotify notendur á tónlist á árinu 2017?", subtitle = "Uppgefin hlustun í mínútum fyrir tíst merkt '#2017wrapped'") +
  theme_minimal()
  
