#!/bin/sh

# Check for DB connection
while ! php artisan db:connectivity-check
do
  echo "Waiting for DB connection..."
  # wait for 5 seconds before check again
  sleep 5
done

# If we're here, we have a DB connection, proceed with starting the application
exec docker-php-entrypoint apache2-foreground