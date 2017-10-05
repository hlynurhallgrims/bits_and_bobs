makasum <- function(x) {
	nafn <- deparse(substitute(x))
	kodi <- paste0(nafn, " + ",nafn, "_m")
	z <- eval(parse(text = kodi))
	z
}
