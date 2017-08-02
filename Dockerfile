# Dockerfile for a ubuntu 14.04 image with stock php 5.5 with all extensions installed.

#
FROM ubuntu:14.04
MAINTAINER Gustavo Reichelt Emmel <gremmel@gmail.com>

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# Our user in the container
USER root
WORKDIR /root

# Need to generate our locale.
RUN locale-gen de_DE de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE.UTF-8

# Update system
RUN apt-get update

# Get PHP 5.6 version
RUN add-apt-repository ppa:ondrej/php

# Update system
RUN apt-get -y update

# Install and Test PHP
RUN apt-get install --no-install-recommends -y \
		curl ca-certificates \
		php5.6 \
		php5.6-mcrypt \
		php5.6-mbstring  \
		php5.6-curl \
		php5.6-cli \
		php5.6-mysql \
		php5-mysql php5-pgsql \
		php5.6-gd \
		php5.6-intl \
		php5.6-xsl \
		php5.6-zip  \
		php5.6-bcmath \
		php5.6-xml  \
		
		php --v && \
		php -m
		
# Tidy up
RUN apt-get -y autoremove && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
RUN curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Install phpunit
RUN curl https://phar.phpunit.de/phpunit-5.4.8.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit


# Allow mounting files
VOLUME ["/root"]

# PHP is our entry point
CMD ["/usr/bin/php"]
