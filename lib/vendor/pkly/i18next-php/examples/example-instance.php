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

$instance = new I18n([
    'lng'           =>  'en',
    'resources'     =>  [
        'en'        =>  [
            'translation'       =>  [
                'instance_key'      =>  'Instance value!',
                'instance_key_deep' =>  [
                    'key'           =>  'Deep instance value!'
                ]
            ]
        ]
    ]
]);

echo "Reading 'instance_key' from instance (from options['resources']) - " . $instance->t('instance_key') . "\n";
// Outputs "Instance value!"
echo "Reading 'instance_key_deep.key' from instance (from options['resources']) - " . $instance->t('instance_key_deep.key') . "\n";
// Outputs "Deep instance value!"

echo "Trying to read key that doesn't exist in shared instance - " . I18n::get()->t('instance_key') . "\n";
// Outputs "instance_key" (key not found in resources)
echo "Trying to read key that doesn't exist in custom instance - " . $instance->t('key') . "\n";
// Outputs "key" (key not found in resources)