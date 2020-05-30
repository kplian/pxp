<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 30.09.2019
 * Time: 13:55
 */

namespace Pkly\I18Next\Tests;


use PHPUnit\Framework\TestCase;
use Pkly\I18Next\Interpolator;

class InterpolatorTest extends TestCase {
    public function testBasicInterpolation() {
        $interpolator = new Interpolator();

        $this->assertEquals('__test__/__data__', $interpolator->interpolate('__{{val1}}__/__{{val2}}__', ['val1' => 'test', 'val2' => 'data']));
        $this->assertEquals('____/__test__/__data__', $interpolator->interpolate('__{{val1}}__/__{{val2}}__/__{{val3}}__', ['val2' => 'test', 'val3' => 'data']));
    }
}