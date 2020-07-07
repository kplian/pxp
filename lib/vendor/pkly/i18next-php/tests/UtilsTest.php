<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 30.09.2019
 * Time: 13:10
 */

namespace Pkly\I18Next\Tests;

use PHPUnit\Framework\TestCase;
use Pkly\I18Next\Utils;

require_once __DIR__ . '/../src/I18Next/Utils.php';

class UtilsTest extends TestCase {
    public function testCapitalize() {
        $this->assertEquals('Test', Utils\capitalize('test'));
        $this->assertEquals('TEST', Utils\capitalize('TEST'));
        $this->assertEquals('TeST', Utils\capitalize('teST'));
    }

    public function testSetPath() {
        $original = [];
        $expected = [
            'final'     =>  'value'
        ];

        Utils\setPath($original, 'final', 'value');
        $this->assertEquals($expected, $original);

        $original = [];
        $expected2 = [
            'deep'      =>  [
                'level'     =>  'value'
            ]
        ];

        Utils\setPath($original, ['deep', 'level'], 'value');
        $this->assertEquals($expected2, $original);
    }

    public function testGetPath() {
        $data = [
            'normal'        =>  'val1',
            'deep'          =>  [
                'here'      =>  'val2'
            ]
        ];

        $this->assertEquals('val1', Utils\getPath($data, 'normal'));
        $this->assertEquals('val2', Utils\getPath($data, ['deep', 'here']));
        $this->assertNull(Utils\getPath($data, 'notrealkey'));
    }

    /**
     * @depends testGetPath
     * @depends testSetPath
     */
    public function testPushPath() {
        $data1 = [
            'normal'        =>  [],
            'deep'          =>  [
                'here'      =>  'val2'
            ]
        ];
        $copy = $data1;

        Utils\pushPath($copy, 'normal', 'val1');
        $data1['normal'] = ['val1'];
        $this->assertEquals($data1, $copy);
    }
}