01\_explore-libraries\_jenny.R
================
u0392095
Wed Jan 31 14:05:32 2018

``` r
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
library(fs)
path_real(.Library)
```

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

Installed packages

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 274

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 3 x 3
    ##                                                          LibPath
    ##                                                            <chr>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## # ... with 2 more variables: Priority <chr>, n <int>

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n       prop
    ##              <chr> <int>      <dbl>
    ## 1               no   121 0.44160584
    ## 2              yes   140 0.51094891
    ## 3             <NA>    13 0.04744526

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n       prop
    ##   <chr> <int>      <dbl>
    ## 1 3.4.0   203 0.74087591
    ## 2 3.4.1    19 0.06934307
    ## 3 3.4.2    49 0.17883212
    ## 4 3.4.3     3 0.01094891

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##   [1] "abind"          "acepack"        "acs"            "animation"     
    ##   [5] "anonymizer"     "arm"            "assertthat"     "backports"     
    ##   [9] "base64enc"      "BH"             "bindr"          "bindrcpp"      
    ##  [13] "bitops"         "blogdown"       "bookdown"       "broom"         
    ##  [17] "caTools"        "cellranger"     "checkmate"      "classInt"      
    ##  [21] "cli"            "clipr"          "clisymbols"     "coda"          
    ##  [25] "colorspace"     "corpcor"        "corrplot"       "corrr"         
    ##  [29] "covr"           "crayon"         "crosstalk"      "curl"          
    ##  [33] "d3Network"      "data.table"     "DBI"            "deldir"        
    ##  [37] "dendextend"     "DEoptimR"       "desc"           "devtools"      
    ##  [41] "dichromat"      "digest"         "diptest"        "doBy"          
    ##  [45] "dplyr"          "e1071"          "eeptools"       "ellipse"       
    ##  [49] "enc"            "evaluate"       "expm"           "fdrtool"       
    ##  [53] "flexmix"        "forcats"        "foreach"        "formatR"       
    ##  [57] "Formula"        "fpc"            "fs"             "gclus"         
    ##  [61] "gdata"          "gdtools"        "geosphere"      "GGally"        
    ##  [65] "ggm"            "ggmap"          "ggplot2"        "ggplot2movies" 
    ##  [69] "ggrepel"        "ggthemes"       "gh"             "git2r"         
    ##  [73] "glasso"         "glue"           "gmodels"        "goftest"       
    ##  [77] "googleway"      "gplots"         "gridExtra"      "gtable"        
    ##  [81] "gtools"         "haven"          "hexbin"         "highr"         
    ##  [85] "Hmisc"          "hms"            "htmlTable"      "htmltools"     
    ##  [89] "htmlwidgets"    "httpuv"         "httr"           "huge"          
    ##  [93] "humaniformat"   "igraph"         "ini"            "irlba"         
    ##  [97] "iterators"      "jpeg"           "jsonlite"       "kernlab"       
    ## [101] "knitr"          "labeling"       "latticeExtra"   "lavaan"        
    ## [105] "lazyeval"       "leaflet"        "LearnBayes"     "lme4"          
    ## [109] "lmtest"         "lubridate"      "magick"         "magrittr"      
    ## [113] "mapproj"        "maps"           "maptools"       "markdown"      
    ## [117] "matrixcalc"     "MatrixModels"   "mclust"         "memisc"        
    ## [121] "memoise"        "mi"             "mime"           "miniUI"        
    ## [125] "minqa"          "mnormt"         "modelr"         "modeltools"    
    ## [129] "multcomp"       "munsell"        "mvtnorm"        "network"       
    ## [133] "nloptr"         "numDeriv"       "openssl"        "packrat"       
    ## [137] "pander"         "pbivnorm"       "pkgconfig"      "PKI"           
    ## [141] "plogr"          "plotly"         "plotrix"        "plyr"          
    ## [145] "png"            "polspline"      "polyclip"       "prabclus"      
    ## [149] "praise"         "prettyunits"    "progress"       "proto"         
    ## [153] "psych"          "purrr"          "qap"            "qgraph"        
    ## [157] "quadprog"       "quantreg"       "R.methodsS3"    "R.oo"          
    ## [161] "R.utils"        "R6"             "RANN"           "rappdirs"      
    ## [165] "raster"         "RColorBrewer"   "Rcpp"           "RcppEigen"     
    ## [169] "RCurl"          "readr"          "readxl"         "registry"      
    ## [173] "rematch"        "rematch2"       "reshape"        "reshape2"      
    ## [177] "rex"            "rgdal"          "rgeos"          "RgoogleMaps"   
    ## [181] "rJava"          "rjson"          "RJSONIO"        "rlang"         
    ## [185] "rmarkdown"      "rms"            "robustbase"     "rprojroot"     
    ## [189] "rsconnect"      "rstudioapi"     "rvest"          "sandwich"      
    ## [193] "scales"         "SciencesPo"     "SDMTools"       "selectr"       
    ## [197] "sem"            "seriation"      "servr"          "sf"            
    ## [201] "shiny"          "shinythemes"    "sna"            "sourcetools"   
    ## [205] "sp"             "SparseM"        "spatialEco"     "SpatialPack"   
    ## [209] "spatstat"       "spatstat.utils" "spdep"          "stargazer"     
    ## [213] "statnet.common" "stringi"        "stringr"        "styler"        
    ## [217] "svglite"        "tensor"         "testthat"       "TH.data"       
    ## [221] "tibble"         "tidyr"          "tidyselect"     "tidyverse"     
    ## [225] "tigris"         "translations"   "trimcluster"    "TSP"           
    ## [229] "udunits2"       "units"          "usethis"        "uuid"          
    ## [233] "vcd"            "viridis"        "viridisLite"    "wesanderson"   
    ## [237] "whisker"        "withr"          "xlsx"           "xlsxjars"      
    ## [241] "XML"            "xml2"           "xtable"         "yaImpute"      
    ## [245] "yaml"           "zoo"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n      prop
    ##    <lgl> <int>     <dbl>
    ## 1  FALSE   168 0.6131387
    ## 2   TRUE   106 0.3868613
