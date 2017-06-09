ohShopify-Sample-App
====================

A sample PHP application that uses ohShopify.php - The PHP Shopify API Adapter

Instructions
====================
- you must get and install ohShopify library
```
cd ohShopify-Sample-App/lib/
git clone git@github.com:cmcdonaldca/ohShopify.php.git
cd ..
mkdir templates_c
# make writeable by apache user
chown :www-data templates_c
chmod g+w templates_c
```
- you must get and install Smarty templates into the lib directory in a folder called Smarty
```
cd ohShopify-Sample-App/lib/
curl http://www.smarty.net/files/Smarty-3.1.4.tar.gz | tar xzvf -
mv Smarty-3.1.4 Smarty
```
- open lib/config.lib.php and put your API Key and Shared Secret

Sample Calls
====================
- have a look in core/index.php to see some sample API calls. 

