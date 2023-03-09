#ARG R_VERSION=latest
ARG R_VERSION=4.1.2

FROM rocker/r-ver:${R_VERSION}

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  curl \
  libxt6 \
  libsodium-dev \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  && rm -rf /var/lib/apt/lists/*

RUN install2.r --error --skipinstalled --ncpus -1 \
  remotes \
  && rm -rf /tmp/downloaded_packages

COPY /scripts/install_packages.R /scripts/install_packages.R
RUN Rscript /scripts/install_packages.R

RUN mkdir -p /data
RUN mkdir -p /scripts
RUN mkdir -p /output

COPY /scripts/script.R /scripts/script.R

ENTRYPOINT ["Rscript", "/scripts/script.R"]
