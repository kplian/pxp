<?php

// Load autoloader from composer or add the library to another autoloader
require_once __DIR__ . '/../vendor/autoload.php';

use Pkly\I18Next\I18n;
use Pkly\I18Next\Plugin\JsonLoader;

I18n::get([
    'lng'                   =>  'en'
])->useModule(new JsonLoader([
    'json_resource_path'    =>  __DIR__ . '/data/{{lng}}/{{ns}}.json'
]))->init();

echo "Reading 'key' from file - " . I18n::get()->t('key') . "\n";
// Outputs "Translation from file"
echo "Reading 'deep.key' from file - " . I18n::get()->t('deep.key') . "\n";
// Outputs "Translation from deeper into file"