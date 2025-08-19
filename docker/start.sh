#!/bin/bash

# Wait for database to be ready
echo "Waiting for database to be ready..."
while ! nc -z db 3306; do
    sleep 1
done

echo "Database is ready!"

# Clear Laravel caches first
echo "Clearing Laravel caches..."
php artisan config:clear || echo "Config clear failed - continuing..."
php artisan route:clear || echo "Route clear failed - continuing..."
php artisan view:clear || echo "View clear failed - continuing..."

# Cache Laravel configuration for production
echo "Caching Laravel configuration..."
php artisan config:cache || echo "Config cache failed - continuing..."
php artisan route:cache || echo "Route cache failed - continuing..."

# Run migrations
echo "Running database migrations..."
php artisan migrate --force || echo "Migration failed - continuing..."

echo "Starting PHP-FPM..."
# Start PHP-FPM
php-fpm
