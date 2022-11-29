#!/bin/bash
sed -i "s,listen =.*,listen = $BACK_HOST_PORT,g" /etc/php/8.1/fpm/pool.d/www.conf;
# Modifying .env for project
sed -i "s,DB_DATABASE.*,DB_DATABASE=$APP_DB,g" /public_html/$REPO_PROJECT_FOLDER/.env;
sed -i "s,DB_USERNAME.*,DB_USERNAME=$APP_DB_USER,g" /public_html/$REPO_PROJECT_FOLDER/.env;
sed -i "s,DB_PASSWORD.*,DB_PASSWORD=$APP_DB_PASS,g" /public_html/$REPO_PROJECT_FOLDER/.env;
sed -i "s,DB_HOST.*,DB_HOST=$APP_DB_HOST,g" /public_html/$REPO_PROJECT_FOLDER/.env;
sed -i "s,DB_PORT.*,DB_PORT=$APP_DB_PORT,g" /public_html/$REPO_PROJECT_FOLDER/.env;
chown -R www-data:www-data /public_html/$REPO_PROJECT_FOLDER/storage; 
chown -R www-data:www-data /public_html/$REPO_PROJECT_FOLDER/bootstrap/cache;
/usr/sbin/service php8.1-fpm start
cd /public_html/$REPO_PROJECT_FOLDER;
sleep 5;
php artisan $ARTISAN_CMD
tail -f /dev/null
