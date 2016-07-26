FROM rmkn/php
MAINTAINER rmkn

COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum -y install php-mysql MariaDB-server
RUN curl -o /tmp/wordpress.tar.gz -SL https://ja.wordpress.org/latest-ja.tar.gz \
        && tar xzf /tmp/wordpress.tar.gz -C /var/www/html/ --strip=1 \
        && rm /tmp/wordpress.tar.gz \
        && chmod 777 /var/www/html \
        && chown -R apache. /var/www/html/*
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

