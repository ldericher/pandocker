# METADATA
FROM ubuntu:18.04
LABEL maintainer="jmm@yavook.de"

# Set the env variables to non-interactive
ENV  \
    DEBIAN_FRONTEND=noninteractive \
    DEBIAN_PRIORITY=critical \
    DEBCONF_NOWARNINGS=yes

# Install locale configuration
RUN \
    set -ex; \
    # begin install block
    apt-get update; apt-get install -y \
        locales \
    # end install block
    ; rm -rf /var/lib/apt/lists/*; \
    locale-gen en_US.UTF-8

# Set locale (character encoding issue)
ENV \
    LANG=en_US.UTF-8

# Install TeXlive + pandoc
RUN \
    set -ex; \
    # begin install block
    apt-get update; apt-get install -y \
        # prereqs
        rsync \
        # builders
        biber \
        latexmk \
        make \
        # LaTeX
        texlive \
        texlive-bibtex-extra \
        texlive-extra-utils \
        texlive-fonts-extra \
        texlive-latex-extra \
        texlive-lang-german \
        # pandoc
        pandoc \
        pandoc-citeproc \
        # miscellaneous
        python3 \
    # end install block
    ; rm -rf /var/lib/apt/lists/*;

COPY \
    sha256sum.txt .

ARG \
    PDFTK_VERSION=3.0.2-2_all

# Install pdftk-java
RUN \
    set -ex; \
    # begin install block
    apt-get update; apt-get install -y \
        # prereqs
        wget \
    # end install block
    ; rm -rf /var/lib/apt/lists/*; \
    # pdftk-java
    wget http://archive.ubuntu.com/ubuntu/pool/universe/p/pdftk-java/pdftk-java_${PDFTK_VERSION}.deb; \
    sha256sum --ignore-missing -c sha256sum.txt; \
    dpkg --unpack pdftk-java_${PDFTK_VERSION}.deb; \
    apt-get install -fy; \
    rm pdftk-java_${PDFTK_VERSION}.deb;

# document root
VOLUME ["/docs"]
WORKDIR /docs
