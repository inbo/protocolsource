FROM rocker/verse
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
org.label-schema.name="RStable" \
org.label-schema.description="A docker image with stable versions of R and a bunch of packages used to check and publish protocols." \
org.label-schema.license="MIT" \
org.label-schema.url="e.g. https://www.inbo.be/" \
org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.vcs-url="https://github.com/inbo/protocolsource" \
org.label-schema.vendor="Research Institute for Nature and Forest" \
maintainer="Hans Van Calster <hans.vancalster@inbo.be>"

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Consolidated apt-get installations
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    nano \
    openssh-client \
    libv8-dev \
    ghostscript \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

## Install pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/3.4/pandoc-3.4-1-amd64.deb \
  && dpkg -i pandoc-3.4-1-amd64.deb \
  && rm pandoc-3.4-1-amd64.deb

## Copy R profile
COPY docker/Rprofile.site $R_HOME/etc/Rprofile.site

## Extend the existing TeXLive installation with additional packages needed
## see https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_texlive.sh
RUN tlmgr update --self && \
     tlmgr install \
     booktabs \
     babel-dutch \
     babel-english \
     babel-french \
     beamer \
     biblatex \
     caption \
     csquotes \
     footnotehyper \
     hyphen-dutch \
     hyphen-french \
     listings \
     mathspec \
     microtype \
     multirow \
     natbib \
     orcidlink \
     parskip \
     setspace \
     soul \
     svg \
     times \
     unicode-math \
     upquote \
     xcolor \
     xurl

## Install R packages
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "renv::consent(provided = TRUE)"
COPY renv.lock renv.lock
RUN R -e "renv::restore()"
RUN R -e "renv::install(c('reactable', 'zen4R', 'keyring'))"
RUN R -e "renv::install('yonicd/slickR@1a469961b203f9260a49b24e3ec78aef3ef54798')"
RUN R -e "renv::isolate()"


## Copy entrypoint scripts
COPY docker/entrypoint_website.sh /entrypoint_website.sh
COPY docker/entrypoint_update.sh /entrypoint_update.sh
COPY docker/entrypoint_check.sh /entrypoint_check.sh
COPY docker/test_docker.sh /test_docker.sh

## Set default entrypoint
ENTRYPOINT ["/entrypoint_check.sh"]

