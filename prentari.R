prentari <- function(data, x, breidd = 2500e3) {  
  nullid <- sym(x)
  fyrra <- sym(paste0(x, "_pros"))
  seinna <- sym(paste0(x, "_pers"))
  
  data %>% 
    mutate(!!fyrra  := !!fyrra  - !!nullid,
           !!seinna := !!seinna - !!nullid) %>% 
    select(.data$etes_s, !!fyrra, !!seinna) %>% 
    filter(.data$etes_s < breidd) %>% 
    gather(-.data$etes_s, key = "key", value = "value") %>% 
    ggplot(mapping = aes(x = etes_s, y = value, color = key)) +
    geom_line()
}  