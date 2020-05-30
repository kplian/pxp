# i18next-php

A port of [i18next](https://www.i18next.com/) in PHP. With a rest API. (coming soon \[tm\])

Code in this repository is largely based on the original code base in JavaScript, rewritten in PHP.
This project focuses only on the newest version of i18next, disregarding compatibility with previous ones.

### Warning!

This version is usable, but could contain bugs. 
If you find any issues please report them or create a PR.

### Features

* PSR3 logging support (psr/log is a hard requirement, but you're not required to actually use a logger)
* Extremely similar API to the JS version
* PHP-specific features like interfaces for modules
* PHP 7.3+ 
* Automatic language detection support

### Usage

[View all examples here](examples)

* [Basic shared usage through the whole application](examples/example-shared.php)
* [Basic instancing of translation and separation from shared](examples/example-instance.php)
* [Basic plural handling](examples/example-plurals.php)
* [Basic language detection](examples/example-detect.php)

### Basic example

```php
// You can also use I18n globally via I18n::get()

$i18n = new I18n([
    'lng'           =>  'en',
    'resources'     =>  [
        'en'        =>  [
            'translation'       =>  [
                'key'           =>  'Value',
                'key_plural'    =>  'Value plural'
                'deeper'        =>  [
                    'key'           =>  'Deep value'
                ]
            ]
        ]
    ]
]);

$i18n->t('key'); // "Value"
$i18n->t('key', ['count' => 5]); // "Value plural"
$i18n->t('deeper.key'); // "Depp value"
```

### Composer

Simply enter your project directory and run

`composer require pkly/i18next-php`

### Todo

* Add event emitting

#### Packagist

Visit the page [here](https://packagist.org/packages/pkly/i18next-php)

#### Donate

If you want feel free to buy me a coffee [by clicking here](https://paypal.me/pklytastic?locale.x=en_US)