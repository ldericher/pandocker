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
		# begin install block
		apt-get update && apt-get install -y \
			locales \
		# end install block
&& 	rm -rf /var/lib/apt/lists/* \
&&  locale-gen en_US.UTF-8

# Set locale (character encoding issue)
ENV \
		LANG=en_US.UTF-8

# Install software
RUN \
		# begin install block
		apt-get update &&	apt-get install -y \
			# builders
			latexmk \
			make \
			# LaTeX
			texlive \
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
&&	rm -rf /var/lib/apt/lists/*

# document root
VOLUME ["/docs"]
WORKDIR /docs
