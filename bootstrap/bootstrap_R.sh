#!/bin/bash

# turn on logging and exit on error
set -e -x

BOOTSTRAP_BUCKET_NAME=r-on-hadoop

# install dependencies neede by R using the FRONTEND call to eliminate
# user interactive requests
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --force-yes libcurl4-openssl-dev cdbs

# grab packages from S3
hadoop dfs -copyToLocal s3n://${BOOTSTRAP_BUCKET_NAME}/R_packages/* .
DEB_HOST_ARCH=`dpkg-architecture -qDEB_HOST_ARCH`

#upgrade R
sudo dpkg -i r-base-core_2.15.2-1~squeezecran.0_${DEB_HOST_ARCH}.deb r-recommended_2.15.2-1~squeezecran.0_all.deb r-base_2.15.2-1~squeezecran.0_all.deb r-base-dev_2.15.2-1~squeezecran.0_all.deb

# for the package update script to run the user hadoop needs to own the R library
sudo chown -R hadoop /usr/lib/R/library
sudo chown -R hadoop /usr/local/lib/R

# install packages
R CMD INSTALL getopt_1.17.tar.gz HadoopStreaming_0.2.tar.gz

R CMD INSTALL bitops_1.0-4.1.tar.gz
R CMD INSTALL RCurl_1.95-1.1.tar.gz
R CMD INSTALL plyr_1.7.1.tar.gz 
R CMD INSTALL stringr_0.6.1.tar.gz
R CMD INSTALL digest_0.5.2.tar.gz
R CMD INSTALL httr_0.2.tar.gz
R CMD INSTALL memoise_0.1.tar.gz
R CMD INSTALL whisker_0.1.tar.gz 
R CMD INSTALL evaluate_0.4.2.tar.gz 
R CMD INSTALL devtools_1.1.tar.gz
