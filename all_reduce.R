all_reduce <- function(years, datasets) {

	ar <- list(years) 
	listi <- datasets
	
	fjoldi <- length(ar)
	utkoma <- vector("list", fjoldi)
	for (i in 2:fjoldi) {
		temp_rammi <- t(combn(x = as.numeric(ar[[1]]):as.numeric(ar[[length(ar)]]), m = i))
		vidbot <- matrix(0L, nrow = nrow(temp_rammi), ncol = fjoldi - i)
		rammi <- cbind(temp_rammi, vidbot)
		
		utkoma[[i]] <- rammi
	}
	utkoma_utlit <- do.call(rbind, utkoma)
	
	utkoma <- vector("list", fjoldi)
	for (j in 2:fjoldi) {
		temp_rammi <- t(combn(x = 1:fjoldi, m = j))
		vidbot <- matrix(0L, nrow = nrow(temp_rammi), ncol = fjoldi - j)
		rammi <- cbind(temp_rammi, vidbot)
		
		utkoma[[j]] <- rammi
	}
	utkoma <- do.call(rbind, utkoma)
	
	samantektar_tafla <- matrix(0L, nrow = nrow(utkoma), ncol = 2)
	for (k in 1:length(utkoma)) {
		lina_vigri <- utkoma[k, ]
		lina_vigri <- lina_vigri[lina_vigri != 0]
		talning <- listi[lina_vigri] %>%
		purrr::reduce(semi_join, by = c("ktaln", "makin")) %>%
		tally()
		
		samantektar_tafla[k, 1] <- length(lina_vigri)
		samantektar_tafla[k, 2] <- as.numeric(talning)
	}
	
	print(cbind(utkoma_utlit, samantektar_tafla))
	

}
