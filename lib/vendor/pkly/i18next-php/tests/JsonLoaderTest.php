<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 01.10.2019
 * Time: 12:18
 */

namespace Pkly\I18Next\Tests;


use PHPUnit\Framework\TestCase;
use Pkly\I18Next\I18n;
use Pkly\I18Next\Plugin\JsonLoader;

class JsonLoaderTest extends TestCase {
    public function testLoading() {
        $i18n = new I18n([
            'lng'                   =>  'en',
            'debug'                 =>  true
        ]);

        $i18n->useModule(new JsonLoader([
            'json_resource_path'    =>  __DIR__ . '/data/{{lng}}/{{ns}}.json'
        ]))->init();

        $this->assertEquals('value from json!', $i18n->t('key'));
        $this->assertEquals('another json value', $i18n->t('second_key'));
        $this->assertEquals('key', $i18n->t('another_ns:key'));
        $this->assertEquals('value from deep!', $i18n->t('third_key.deep'));
    }
}