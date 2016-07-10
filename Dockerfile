FROM r-base

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

RUN sudo su - -c "/usr/bin/R -e \"install.packages(c('Cairo', 'brew', 'flexmix', 'magrittr', 'modeltools', 'quantreg', 'rjson', 'Rook', 'stringi', 'stringr', 'Rcpp', 'RcppArmadillo', 'Formula', 'Hmisc', 'latticeExtra', 'RColorBrewer', 'SparseM', 'XML', 'git2r', 'pbkrtest', 'RMTstat', 'extRemes', 'devtools'), repos='http://cran.r-project.org')\""
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("edgeR"); biocLite("DESeq2");'

RUN sudo su - -c "/usr/bin/R -e \"install.packages(c('futile.logger'), repos='http://cran.r-project.org')\""

RUN sudo su - -c "/usr/bin/R -e \"devtools::install_github('hms-dbmi/scde', build_vignettes = FALSE)\""

