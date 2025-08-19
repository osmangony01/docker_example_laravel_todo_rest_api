#!/bin/bash

echo "Testing database connection..."

# Wait for MySQL to be ready
while ! mysqladmin ping -h db -u user -puser --silent; do
    echo "Waiting for MySQL to be ready..."
    sleep 2
done

echo "MySQL is ready!"

# Clear Laravel configuration cache
echo "Clearing Laravel configuration cache..."
php artisan config:clear

# Test database connection
echo "Testing Laravel database connection..."
php artisan tinker --execute="DB::connection()->getPdo(); echo 'Database connected successfully!'"

# Run migrations
echo "Running migrations..."
php artisan migrate --force

echo "Done!"
