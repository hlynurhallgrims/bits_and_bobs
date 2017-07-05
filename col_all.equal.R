col_all.equal <- function(x, y) {
	if (ncol(x) == ncol(y)){ #Only continue if data.frames have equal number of columns
		width <- ncol(x)
		df_AE <- as.data.frame(matrix(0L, nrow = width, ncol = 3))
		names(df_AE) <- c("col_number", "x_name", "AE_result")
		class(df_AE$col_number) <- "numeric";
		class(df_AE$x_name) <- "character";
		class(df_AE$AE_result) <- "character"
		for (i in 1:width) {
			res <- all.equal(x[, i], y[, i])
			df_AE[i,1] <- i
			df_AE[i,2] <- names(x)[i]
			df_AE[i,3] <- res
		}
		df_AE_false <- df_AE %>% 
			filter(AE_result != TRUE)
		print(df_AE)
	}
	else{
			stop("Differing number of columns between data.frames")
	}
}
