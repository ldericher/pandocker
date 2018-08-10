# METADATA
FROM ubuntu:latest
LABEL maintainer="jmm@yavook.de"

RUN \
	# install locale configuration \
	apt-get update && apt-get install -y \
		locales \
	&& rm -rf /var/lib/apt/lists/* &&\
	\
	# generate en_US.UTF-8 locale \
	sed -ie 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&\
	locale-gen

ENV \
	# set locale (character encoding issue) \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US:en \
	LC_ALL=en_US.UTF-8 \
	\
	# set timezone (install prompt) \
	TZ=Etc/UTC

RUN \
	# actually set timezone \
	ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime &&\
	echo ${TZ} > /etc/timezone &&\
	\
	# install software \
	apt-get update && apt-get install -y \
		latexmk \
		locales \
		make \
		pandoc \
		python3 \
		texlive \
		texlive-fonts-extra \
		texlive-latex-extra \
		texlive-lang-german \
	&& rm -rf /var/lib/apt/lists/*

# document root
VOLUME ["/docs"]
WORKDIR /docs
