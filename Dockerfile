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

COPY \
		pdftk-java_3.0.2-2_all.sha256 .

# Install software
RUN \
		# begin install block
		apt-get update &&	apt-get install -y \
			# prereqs
			wget \
		# pdftk-java
&&	wget http://archive.ubuntu.com/ubuntu/pool/universe/p/pdftk-java/pdftk-java_3.0.2-2_all.deb \
&&	sha256sum -c pdftk-java_3.0.2-2_all.sha256 \
&&	dpkg --unpack pdftk-java_3.0.2-2_all.deb \
&& 	apt-get install -fy \
&&  rm pdftk-java_3.0.2-2_all.deb \
&&	apt-get install -y \
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
