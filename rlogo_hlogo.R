library(tidyverse)

rammi <- tibble(x = seq(-10, 10, by = 0.01),
                y = x)

rammi %>% 
  ggplot(aes(x = x, y = y)) + 
  geom_ellipse(aes(x0 = 0, y0 = 0, a = 10, b = 8, angle = 0), fill = "#98939A", color = "#98939A") +
  geom_ellipse(aes(x0 = 1.5, y0 = -1, a = 7.5, b = 6, angle = 0), fill = "white", color = "white") +
  geom_text(x = 3.3, y = -4.5, label = "R", color = "#2369BE", size = 112, fontface = "bold") +
  coord_cartesian(xlim = c(-10, 10), ylim = c(-12, 12)) +
  theme(plot.background = element_rect(fill = "transparent"),
        panel.background = element_rect(fill = "transparent"),
        rect = element_rect(fill = "transparent"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

rammi %>% 
  ggplot(aes(x = x, y = y)) + 
  geom_ellipse(aes(x0 = 0, y0 = 0, a = 10, b = 8, angle = 0), fill = "#98939A", color = "#98939A") +
  geom_ellipse(aes(x0 = 1.5, y0 = -1, a = 7.5, b = 6, angle = 0), fill = "white", color = "white") +
  geom_text(x = 3.3, y = -4.5, label = "H", color = "#2369BE", size = 112, fontface = "bold") +
  coord_cartesian(xlim = c(-10, 10), ylim = c(-12, 12)) +
  theme(plot.background = element_rect(fill = "transparent"),
        panel.background = element_rect(fill = "transparent"),
        rect = element_rect(fill = "transparent"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
