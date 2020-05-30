<?php

// Load autoloader from composer or add the library to another autoloader
require_once __DIR__ . '/../vendor/autoload.php';

use Pkly\I18Next\I18n;

I18n::get([
    'lng'                   =>  'en',
    'resources'             =>  [
        'en'                =>  [
            'translation'       =>  [
                'key'               =>  'Single',
                'key_plural'        =>  'Plural',
                'keyWCount'         =>  '{{count}} item',
                'keyWCount_plural'  =>  '{{count}} items'
            ]
        ]
    ]
]);

echo "Fetching single item - " . I18n::get()->t('key', ['count' => 1]) . "\n";
// Outputs "Single"
echo "Fetching plural item - " . I18n::get()->t('key', ['count' => 2]) . "\n";
// Outputs "Plural"

echo "Fetching single item with variable - " . I18n::get()->t('keyWCount', ['count' => 1]) . "\n";
// Outputs "1 item"
echo "Fetching plural item with variable - " . I18n::get()->t('keyWCount', ['count' => 2]) . "\n";
// Outputs "2 items"