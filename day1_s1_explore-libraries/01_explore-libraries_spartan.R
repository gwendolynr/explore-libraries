#' Which libraries does R search for packages?

.Library
.libPaths()

#' Installed packages

installed.packages()

## use installed.packages() to get all installed packages

packages <- installed.packages() %>% as_data_frame()

## how many packages?

273

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

packages %>% count(LibPath, Priority) 
packages %>% group_by(LibPath, Priority) %>% summarise(count = n())

##   * what proportion need compilation?

packages %>% 
  group_by(NeedsCompilation) %>% 
  summarise(count = n()) %>%  
  mutate(perc=(count/sum(count))) 
 

##   * how break down re: version of R they were built on
packages %>% 
  count(Built) %>% 
  mutate(perc = n / sum(n))

#' Reflections


## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- packages %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
##   * how does the result of .libPaths() relate to the result of .Library?
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
