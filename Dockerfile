# from AWS AMI Image
# see http://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/amazon_linux_container_image.html
# see http://qiita.com/taishin/items/1305d4f97ffe08e24bb0
FROM 137112412989.dkr.ecr.ap-northeast-1.amazonaws.com/amazonlinux:latest

# Apache
RUN yum -y install httpd24
RUN sed -i -e "s/Listen 80/Listen 8000/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes +FollowSymLinks/" /etc/httpd/conf/httpd.conf

# PHP 5.6
RUN yum -y install php56-devel php56-pdo php56-pecl-apcu php56-mysqlnd php56-opcache uuid-php56

# Phalcon 2.0.13
RUN yum -y install gcc make git
RUN git clone git://github.com/phalcon/cphalcon.git && cd cphalcon/build && git checkout -b phalcon-v2.0.13 && ./install
RUN echo 'extension=phalcon.so' > /etc/php-5.6.d/phalcon.ini

ENTRYPOINT /usr/sbin/httpd -D FOREGROUND

EXPOSE 8000
