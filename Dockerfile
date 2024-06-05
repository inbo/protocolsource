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

## Install nano
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    nano

COPY docker/Rprofile.site $R_HOME/etc/Rprofile.site

## Install pandoc
RUN  wget https://github.com/jgm/pandoc/releases/download/3.1.11/pandoc-3.1.11-1-amd64.deb \
  && dpkg -i pandoc-3.1.11-1-amd64.deb \
  && rm pandoc-3.1.11-1-amd64.deb

## Install git depencencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    openssh-client

## Install rgdal dependencies (needed if renv contains rgdal)
#RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
#    gdal-bin \
#    libgdal-dev \
#    libproj-dev \
#    proj-bin

## Install V8 dependencies
RUN  apt-get update \
  && apt-get install -y --no-install-recommends \
     libv8-dev

## Install tinytex
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    r-cran-tinytex
RUN  Rscript -e 'tinytex::install_tinytex(force = TRUE)'

## Install LaTeX packages
RUN apt-get update \
  && apt-get install -y  --no-install-recommends \
    ghostscript \
  && Rscript -e 'tinytex::tlmgr_install(c("amsmath", "amssymb", "array", "babel-dutch", "babel-english", "babel-french", "beamer", "beamerarticle", "biblatex", "bookmark", "booktabs", "calc", "caption", "csquotes", "dvips", "etoolbox", "fancyvrb", "fontenc", "fontspec", "footnote", "footnotehyper", "geometry", "graphicx", "helvetic", "hyperref", "hyphen-dutch", "hyphen-french", "iftex", "inconsolata", "inputenc", "listings", "lmodern", "longtable", "luatexja-preset", "luatexja-fontspec", "mathspec", "microtype", "multirow", "natbib", "orcidlink", "parskip", "pgfpages", "scrreprt", "selnolig", "setspace", "soul", "svg", "tex", "textcomp", "times", "unicode-math", "upquote", "url", "xcolor", "xeCJK", "xurl"))'

WORKDIR /github/workspace

RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "renv::consent(provided = TRUE)"
COPY renv.lock renv.lock
RUN R -e "renv::restore()"
RUN R -e "renv::isolate()"

COPY docker/entrypoint_website.sh /entrypoint_website.sh
COPY docker/entrypoint_update.sh /entrypoint_update.sh
COPY docker/entrypoint_check.sh /entrypoint_check.sh
COPY docker/test_docker.sh /test_docker.sh

ENTRYPOINT ["/entrypoint_check.sh"]
