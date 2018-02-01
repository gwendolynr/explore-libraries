#' @examples
#' df <- data.frame(x = 1, y = 2)
#' path <- tempdir()

col_write <- function(df, path = tempdir()) {
  filename <- paste0(path, "/", names(df), ".txt")

  # for(i in seq_along(df)) {
  #   write_csv(df[[i]], filename[[i]])
  # }
  # walk2(df, filename, ~ writeLines(as.character(.x), .y))
  walk2(df, filename, function(col, filename) {
    writeLines(as.character(col), filename)
  })

}
