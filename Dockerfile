FROM rocker/r-base:latest

# Update
RUN apt-get update

# Install wget
RUN apt-get install -y wget
RUN apt-get install -y sudo
RUN apt-get install -y apt-utils


#Install R packages
RUN apt-get install -y --force-yes \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libcurl4-gnutls-dev

RUN apt-get install -y --force-yes \
    r-cran-colorspace \
    r-cran-dichromat \
    r-cran-digest \
    r-cran-ggplot2 \
    r-cran-gtable \
    r-cran-labeling \
    r-cran-munsell \
    r-cran-plyr \
    r-cran-proto \
    r-cran-reshape \
    r-cran-rjson \
    r-cran-scales \
    r-cran-snow \
    r-cran-xtable 

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" \
      | tee /etc/apt/sources.list.d/webupd8team-java.list \
    &&  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" \
      | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" \
        | /usr/bin/debconf-set-selections \
    && apt-get update \
    && apt-get install -y oracle-java8-installer \
    && update-alternatives --display java \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && R CMD javareconf

## Install rJava package
RUN install2.r --error rJava \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


RUN sudo su - -c "/usr/bin/R -e \"install.packages(c('Cairo', 'brew', 'flexmix', 'magrittr', 'modeltools', 'quantreg', 'rjson', 'Rook', 'stringi', 'stringr', 'Rcpp', 'RcppArmadillo', 'Formula', 'Hmisc', 'latticeExtra', 'RColorBrewer', 'SparseM', 'XML', 'git2r', 'pbkrtest', 'RMTstat', 'extRemes', 'devtools', 'futile.logger'), repos='http://cran.r-project.org')\""

RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("edgeR"); biocLite("DESeq2"); biocLite("lfa");'

RUN sudo su - -c "/usr/bin/R -e \"devtools::install_github('hms-dbmi/scde', build_vignettes = FALSE)\""

RUN sudo su - -c "/usr/bin/R -e \"devtools::install_github('satijalab/seurat')\""



