# Use the PHP and Apache image
FROM php:8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Install necessary packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    libmemcached-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql zip \
    && rm -rf /var/lib/apt/lists/*

# install redis support
RUN pecl install redis \
    && docker-php-ext-enable redis

# install memcached
RUN pecl install memcached-3.2.0 \
    && docker-php-ext-enable memcached

# setup httpd
COPY 000-default.conf /etc/apache2/sites-available/
RUN a2ensite 000-default

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy the Laravel application files into the container
COPY . /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Update Laravel dependencies using Composer (ignoring PHP extension)
RUN composer update --ignore-platform-req=ext-exif --no-scripts \
    && composer install --ignore-platform-req=ext-exif --no-scripts

# install minio driver
RUN composer require --ignore-platform-req=ext-exif --update-with-all-dependencies coraxster/flysystem-aws-s3-v3-minio --no-scripts

# Set necessary permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Expose the HTTP port
EXPOSE 80

# Copy the entrypoint script into the image
COPY entrypoint.sh /usr/local/bin/

# Make sure the script is executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use the script as the default command for the container
ENTRYPOINT ["entrypoint.sh"]