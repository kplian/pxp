<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 09.10.2019
 * Time: 14:27
 */

namespace Pkly\I18Next\Tests;

use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Monolog\Test\TestCase;
use Pkly\I18Next\I18n;
use Pkly\I18Next\Plugin\Detector\Cookie;
use Pkly\I18Next\Plugin\Detector\Query;
use Pkly\I18Next\Plugin\Detector\Session;
use Pkly\I18Next\Plugin\LanguageDetector;

class DetectionTest extends TestCase {
    public function testCookieDetection() {
        $i18n = new I18n([
            'lng'           =>  'ru',
            'debug'         =>  true,
            'resources'     =>  [
                'en'        =>  [
                    'translation'       =>  [
                        'key'           =>  'value',
                        'deep'          =>  [
                            'key'       =>  'value2'
                        ]
                    ]
                ]
            ]
        ], new Logger('cookie_detect', [new StreamHandler('php://stdout')]));

        $i18n->useModule(new LanguageDetector([
            'cookie'            =>  Cookie::class
        ], [
            'lookupCookie'      =>  'i18n'
        ]))->init();

        $_COOKIE['i18n'] = 'en';

        $i18n->changeLanguage('');

        $this->assertEquals('value', $i18n->t('key'));
    }

    public function testQueryDetection() {
        $i18n = new I18n([
            'lng'           =>  'ru',
            'debug'         =>  true,
            'resources'     =>  [
                'en'        =>  [
                    'translation'       =>  [
                        'key'           =>  'value',
                        'deep'          =>  [
                            'key'       =>  'value2'
                        ]
                    ]
                ]
            ]
        ], new Logger('query_detect', [new StreamHandler('php://stdout')]));

        global $cached;

        $i18n->useModule(new LanguageDetector([
            'query'                     =>  Query::class
        ], [
            'caches'                    =>  [
                'query'
            ],
            'lookupQuery'               =>  'i18n',
            'cacheUserLanguageQuery'    =>  function($lng) {
                global $cached;
                $cached = $lng;
            }
        ]))->init();

        $_GET['i18n'] = 'en';

        $i18n->changeLanguage('');

        $this->assertEquals('value', $i18n->t('key'));
        $this->assertEquals('en', $cached);
    }

    public function testSessionDetection() {
        $i18n = new I18n([
            'lng'           =>  'ru',
            'debug'         =>  true,
            'resources'     =>  [
                'en'        =>  [
                    'translation'       =>  [
                        'key'           =>  'value',
                        'deep'          =>  [
                            'key'       =>  'value2'
                        ]
                    ]
                ]
            ]
        ], new Logger('session_detect', [new StreamHandler('php://stdout')]));

        $i18n->useModule(new LanguageDetector([
            'session'               =>  Session::class
        ], [
            'caches'                =>  [
                'query'
            ],
            'lookupSession'         =>  ['t_session', 't_var']
        ]))->init();

        $_SESSION['t_session'] = [
            't_var'     =>  'en'
        ];

        $i18n->changeLanguage('');

        $this->assertEquals('value', $i18n->t('key'));
    }
}