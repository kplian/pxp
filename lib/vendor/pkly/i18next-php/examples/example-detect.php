<?php

// Load autoloader from composer or add the library to another autoloader
require_once __DIR__ . '/../vendor/autoload.php';

use Pkly\I18Next\I18n;
use Pkly\I18Next\Plugin\JsonLoader;
use Pkly\I18Next\Plugin\LanguageDetector;

I18n::get([
    'lng'                   =>  'ru', // incorrect language that doesn't have any strings - it'd return keys
    'fallbackLng'           =>  null // disabled fallback lng, so that keys will be printed out on failed load
])->useModule(new JsonLoader([
    'json_resource_path'    =>  __DIR__ . '/data/{{lng}}/{{ns}}.json'
]))->useModule(new LanguageDetector([
    'query'             =>  \Pkly\I18Next\Plugin\Detector\Query::class
], [
    'lookupQuery'       =>  'i18n_lng'
]))->init();

echo "Reading 'key' from file - " . I18n::get()->t('key') . "\n";
// Outputs "key"
echo "Reading 'deep.key' from file - " . I18n::get()->t('deep.key') . "\n";
// Outputs "deep.key"

// at some point there was a get parameter called i18n_lng
$_GET['i18n_lng'] = 'en';

// detect language
I18n::get()->changeLanguage('');

echo "Reading 'key' from file - " . I18n::get()->t('key') . "\n";
// Outputs "Translation from file"
echo "Reading 'deep.key' from file - " . I18n::get()->t('deep.key') . "\n";
// Outputs "Translation from deeper into file"