ponies <- c(
  "Twilight Sparkle",
  "Rainbow Dash",
  "Pinkie Pie",
  "Applejack",
  "Rarity",
  "Fluttershy"
)

rpony <- function(n) {
  cat("!!!!!!")
  sample(ponies, n, replace = TRUE)
}

rpony2 <- function() {
  rpony(2)
}
