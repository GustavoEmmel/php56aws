FROM amazonlinux

MAINTAINER Gustavo Reichelt Emmel <gremmel@gmail.com>

RUN yum update -y && \
	yum install -y gcc make && \
    yum install httpd24 -y && \
    yum install -y nginx php56-fpm && \
    yum install -y php56-devel php-mysql php56-pdo php56-pear php56-mbstring php56-cli php56-odbc php56-imap php56-gd php56-xml php56-soap && \
    yum install php56-mysqlnd && \
    
    yum install -y php56-pecl-apc && \
    yum install -y pcre-devel && \
    yum -y install mysql-server mysql && \
    yum install php56-mysqlnd

RUN sed -i -e "s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes +FollowSymLinks/" /etc/httpd/conf/httpd.conf
RUN chkconfig httpd on
RUN chkconfig nginx on
RUN chkconfig mysqld on
RUN chkconfig php-fpm on

expose 80
expose 443

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
