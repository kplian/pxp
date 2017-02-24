PhpDox for Symfony 2
====================

This repo is used to install PhpDocX in Symfony 2, using Composer.

I can't answer your questions about PhpDocX, so please refer to the library documentation : http://www.phpdocx.com/documentation

More information about Symfony 2 here : http://www.symfony.com

More information about Composer here : https://getcomposer.org/


Installation
------------

Add this to your composer.json file :

    "phpdocx/phpdocx"                     : "3.7"

Then launch :

	composer.phar update


Create config file :

	cp vendor/phpdocx/phpdocx/config/phpdocxconfig.ini.dist vendor/phpdocx/phpdocx/config/phpdocxconfig.ini

Edit vendor/phpdocx/phpdocx/config/phpdocxconfig.ini & set your licence code


That's all.