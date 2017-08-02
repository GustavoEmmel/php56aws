FROM internavenue/centos-base:centos7

MAINTAINER Gustavo Reichelt Emmel <gremmel@gmail.com>

# Install Remi Collet's repo for CentOS 7
RUN yum -y install \
  http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
  http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

# Install PHP and Percona (MySQL) client stuff and the latest stable PHP.
RUN yum -y install --enablerepo=remi,remi-php56 \
  Percona-Server-client-56 \
  php-cli \
  php-fpm \
  php-gd \
  php-mbstring \
  php-mcrypt \
  php-mysqlnd \
  php-opcache \
  php-pdo \
  php-pear \
  php-soap \
  php-xml \
  php-pecl-imagick \
  php-pecl-apcu

# Clean up YUM when done.
RUN yum clean all

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

# Expose our web root and log directories log.
VOLUME ["/srv/www", "/var/log", "/var/lib/php", "/run", "/vagrant"]

EXPOSE 9000 22
