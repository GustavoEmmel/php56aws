FROM ubuntu:12.04

# Install dependencies
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update -y
RUN apt-get install -y git curl
RUN apt-get install -y software-properties-common
RUN apt-get install -y git php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-bcmath php5.6-curl php-mongodb composer
