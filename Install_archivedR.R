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
