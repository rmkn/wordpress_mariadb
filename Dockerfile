FROM centos:6
MAINTAINER bobblun
RUN yum -y update
RUN yum -y install httpd php php-mysql
RUN curl -o /tmp/wordpress.tar.gz -SL https://ja.wordpress.org/latest-ja.tar.gz \
        && tar xzf /tmp/wordpress.tar.gz -C /var/www/html/ --strip=1 \
        && rm /tmp/wordpress.tar.gz \
        && chmod 777 /var/www/html
COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum -y install MariaDB-server
EXPOSE 80
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

