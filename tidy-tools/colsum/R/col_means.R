col_means <- function(df) {
  df %>%
    keep(is.numeric) %>%
    map_dfc(mean)
}
