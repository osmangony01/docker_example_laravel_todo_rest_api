-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS todo_curd_rest_api;

-- Create user and grant privileges
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES ON todo_curd_rest_api.* TO 'user'@'%';
FLUSH PRIVILEGES;
