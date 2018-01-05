FROM wordpress:4.9.1

ENV WORDPRESS_CLI_VERSION 1.4.1

USER root
WORKDIR /tmp/
RUN curl -L -o wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v${WORDPRESS_CLI_VERSION}/wp-cli-${WORDPRESS_CLI_VERSION}.phar && \
    chmod +x wp-cli.phar && \
    php wp-cli.phar --info && \
    mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update && \
    apt-get install -y mysql-client && \
    apt-get clean


COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER www-data
WORKDIR /var/www/html

CMD ["wp", "shell"]
