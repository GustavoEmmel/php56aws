# from AWS AMI Image

FROM amazonlinux

# Apache
RUN yum -y install httpd24
RUN sed -i -e "s/Listen 80/Listen 8000/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes +FollowSymLinks/" /etc/httpd/conf/httpd.conf

# PHP 5.6
RUN yum -y install php56-devel php56-pdo php56-pecl-apcu php56-mysqlnd php56-opcache uuid-php56

ENTRYPOINT /usr/sbin/httpd -D FOREGROUND

EXPOSE 8000
