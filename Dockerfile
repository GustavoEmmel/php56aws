FROM ubuntu:16.04

MAINTAINER Alexey Nurgaliev <atnurgaliev@gmail.com>

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ADD docker /docker

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y software-properties-common &&\
    add-apt-repository -y ppa:ondrej/php &&\
    add-apt-repository -y ppa:nginx/stable &&\
    apt-get update &&\
    apt-get install -y \
      nginx \
      php5.6-fpm php5.6-cli php5.6-cgi \
      php5.6-interbase php5.6-pgsql php5.6-mysql \
      php5.6-curl php5.6-mbstring \
      php5.6-gd php5.6-xml php5.6-zip php5.6-json \
      php-pear php-igbinary php-mongo php-redis &&\
    apt-get purge -y --auto-remove software-properties-common &&\

    rm /etc/nginx/sites-enabled/* &&\
    cp /docker/nginx/nginx_vhost \
       /etc/nginx/sites-available/ &&\
    ln -s /etc/nginx/sites-available/nginx_vhost \
        /etc/nginx/sites-enabled/nginx_vhost &&\

    cp /docker/fpm/php-fpm.conf /etc/php/5.6/fpm/php-fpm.conf &&\
    cp /docker/fpm/www.conf /etc/php/5.6/fpm/pool.d/www.conf &&\

    rm -R /var/www/* &&\
    mkdir -p -m 0755 /var/www/html &&\
    chown www-data:www-data /var/www/html &&\
    cp /docker/index.php /var/www/html/index.php &&\

    rm -R /docker

VOLUME ["/var/www/html/", "/var/lib/php/sessions"]

EXPOSE 80

CMD php-fpm5.6 --allow-to-run-as-root --nodaemonize \
               --fpm-config /etc/php/5.6/fpm/php-fpm.conf & \
    nginx -g "daemon off;"
