## Using samr as example
## In ubuntu
## os X and windows are different

## install dependencies
source("https://bioconductor.org/biocLite.R")
biocLite("impute")
# Download package tarball from CRAN archive

url <- "http://cran.r-project.org/src/contrib/Archive/samr/samr_2.0.tar.gz"
pkgFile <- "samr_2.0.tar.gz"
download.file(url = url, destfile = pkgFile)

# Install package
install.packages(pkgs=pkgFile, type="source", repos=NULL)

# Delete package tarball
unlink(pkgFile)

#########################
### for Windows
#########################

# this is to rebuild the package from the github code by devtools and Rtools 
library(devtools)
assignInNamespace("version_info", c(devtools:::version_info, list("3.5" = list(version_min = "3.3.0", version_max = "99.99.99", path = "bin"))), "devtools")
find_rtools() # is TRUE now

install_github("cran/samr")
