FROM amazonlinux

MAINTAINER Kenta Oouchida <oouchida@gmail.com>

RUN yum update -y && \
	yum install vim git -y && \
	yum install httpd24 -y && \
	yum install php70 -y && \
	yum install php70-mbstring php70-pdo php70-mysqlnd php70-opcache -y

RUN sed -i -e "s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes +FollowSymLinks/" /etc/httpd/conf/httpd.conf
RUN chkconfig httpd on

expose 80
expose 443

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
