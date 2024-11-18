#!/bin/bash
sudo systemctl restart apache2
cd /var/www/html/hexoltpgpayments && php artisan view:clear
#sudo supervisorctl reread
#sudo supervisorctl update
sudo systemctl restart supervisor.service
