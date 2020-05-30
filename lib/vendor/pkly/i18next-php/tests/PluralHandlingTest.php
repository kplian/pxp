<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 04.10.2019
 * Time: 08:49
 */

namespace Pkly\I18Next\Tests;

use PHPUnit\Framework\TestCase;
use Pkly\I18Next\I18n;

class PluralHandlingTest extends TestCase {
    public function testBasic() {
        $i18n = new I18n([
            'lng'               =>  'en',
            'debug'             =>  true,
            'resources'         =>  [
                'en'            =>  [
                    'translation'       =>  [
                        'key'                   =>  'Item',
                        'key_plural'            =>  'Items',
                        'kWithCount'            =>  '{{count}} item',
                        'kWithCount_plural'     =>  '{{count}} items'
                    ]
                ]
            ]
        ]);

        $this->assertEquals('Items', $i18n->t('key', ['count' => 0]));
        $this->assertEquals('Item', $i18n->t('key', ['count' => 1]));
        $this->assertEquals('Items', $i18n->t('key', ['count' => 4]));
        $this->assertEquals('1 item', $i18n->t('kWithCount', ['count' => 1]));
        $this->assertEquals('5 items', $i18n->t('kWithCount', ['count' => 5]));
    }
}