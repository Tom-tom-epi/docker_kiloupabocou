FROM php:7.4-fpm-alpine

#Apk install 
RUN apk --no-cache update && apk --no-cache add bash git

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&  php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer

# PDO mysql
RUN docker-php-ext-install pdo_mysql

# Symfony
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

WORKDIR /var/www/html