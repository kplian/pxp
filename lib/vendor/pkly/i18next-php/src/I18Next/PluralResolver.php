<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 26.09.2019
 * Time: 09:47
 */

namespace Pkly\I18Next;

use Psr\Log\LoggerInterface;
use Psr\Log\NullLogger;

/**
 * @author i18next.com
 */
const SETS = [
    [
        'lngs'  =>  ['ach','ak','am','arn','br','fil','gun','ln','mfe','mg','mi','oc', 'pt', 'pt-BR',
            'tg','ti','tr','uz','wa'],
        'nr'    =>  [1,2],
        'fc'    =>  1
    ],
    [
        'lngs'  =>  ['af','an','ast','az','bg','bn','ca','da','de','dev','el','en',
            'eo','es','et','eu','fi','fo','fur','fy','gl','gu','ha','hi',
            'hu','hy','ia','it','kn','ku','lb','mai','ml','mn','mr','nah','nap','nb',
            'ne','nl','nn','no','nso','pa','pap','pms','ps','pt-PT','rm','sco',
            'se','si','so','son','sq','sv','sw','ta','te','tk','ur','yo'],
        'nr'    =>  [1,2],
        'fc'    =>  2
    ],
    [
        'lngs'  =>  ['ay','bo','cgg','fa','id','ja','jbo','ka','kk','km','ko','ky','lo',
            'ms','sah','su','th','tt','ug','vi','wo','zh'],
        'nr'    =>  [1],
        'fc'    =>  3
    ],
    [
        'lngs'  =>  ['be','bs', 'cnr', 'dz','hr','ru','sr','uk'],
        'nr'    =>  [1,2,5],
        'fc'    =>  4
    ],
    [
        'lngs'  =>  ['ar'],
        'nr'    =>  [0,1,2,3,11,100],
        'fc'    =>  5
    ],
    [
        'lngs'  =>  ['cs','sk'],
        'nr'    =>  [1,2,5],
        'fc'    =>  6
    ],
    [
        'lngs'  =>  ['csb','pl'],
        'nr'    =>  [1,2,5],
        'fc'    =>  7
    ],
    [
        'lngs'  =>  ['cy'],
        'nr'    =>  [1,2,3,8],
        'fc'    =>  8
    ],
    [
        'lngs'  =>  ['fr'],
        'nr'    =>  [1,2],
        'fc'    =>  9
    ],
    [
        'lngs'  =>  ['ga'],
        'nr'    =>  [1,2,3,7,11],
        'fc'    =>  10
    ],
    [
        'lngs'  =>  ['gd'],
        'nr'    =>  [1,2,3,20],
        'fc'    =>  11
    ],
    [
        'lngs'  => ['is'],
        'nr'    =>  [1,2],
        'fc'    =>  12
    ],
    [
        'lngs'  =>  ['jv'],
        'nr'    =>  [0,1],
        'fc'    =>  13
    ],
    [
        'lngs'  =>  ['kw'],
        'nr'    =>  [1,2,3,4],
        'fc'    =>  14
    ],
    [
        'lngs'  =>  ['lt'],
        'nr'    =>  [1,2,10],
        'fc'    =>  15
    ],
    [
        'lngs'  =>  ['lv'],
        'nr'    =>  [1,2,0],
        'fc'    =>  16
    ],
    [
        'lngs'  =>  ['mk'],
        'nr'    =>  [1,2],
        'fc'    =>  17
    ],
    [
        'lngs'  =>  ['mnk'],
        'nr'    =>  [0,1,2],
        'fc'    =>  18
    ],
    [
        'lngs'  =>  ['mt'],
        'nr'    =>  [1,2,11,20],
        'fc'    =>  19
    ],
    [
        'lngs'  =>  ['or'],
        'nr'    =>  [2,1],
        'fc'    =>  2
    ],
    [
        'lngs'  =>  ['ro'],
        'nr'    =>  [1,2,20],
        'fc'    =>  20
    ],
    [
        'lngs'  =>  ['sl'],
        'nr'    =>  [5,1,2,3],
        'fc'    =>  21
    ],
    [
        'lngs'  =>  ['he'],
        'nr'    =>  [1,2,20,21],
        'fc'    =>  22
    ]
];

/**
 * Get rules for plural types
 *
 * This is a workaround for getting a const array with functions as values, as that's not allowed in PHP,
 * data provided by i18next.com
 *
 * @return array
 */
function getRulesForPluralTypes(): array
{
    return [
        1 => function ($n) {
            return (int)($n > 1);
        },
        2 => function ($n) {
            return (int)($n !== 1);
        },
        3 => function ($n) {
            return 0;
        },
        4 => function ($n) {
            return (int)(($n % 10 == 1 && $n % 100 != 11 ? 0 : $n % 10 >= 2 && $n % 10 <= 4 && ($n % 100 < 10 || $n % 100 >= 20)) ? 1 : 2);
        },
        5 => function ($n) {
            return (int)((((($n === 0 ? 0 : $n == 1) ? 1 : $n == 2) ? 2 : $n % 100 >= 3 && $n % 100 <= 10) ? 3 : $n % 100 >= 11) ? 4 : 5);
        },
        6 => function ($n) {
            return (int)((($n == 1) ? 0 : ($n >= 2 && $n <= 4)) ? 1 : 2);
        },
        7 => function ($n) {
            return (int)(($n == 1 ? 0 : $n % 10 >= 2 && $n % 10 <= 4 && ($n % 100 < 10 || $n % 100 >= 20)) ? 1 : 2);
        },
        8 => function ($n) {
            return (int)(((($n == 1) ? 0 : ($n == 2)) ? 1 : ($n != 8 && $n != 11)) ? 2 : 3);
        },
        9 => function ($n) {
            return (int)($n >= 2);
        },
        10 => function ($n) {
            return (int)(((($n == 1 ? 0 : $n == 2) ? 1 : $n < 7) ? 2 : $n < 11) ? 3 : 4);
        },
        11 => function ($n) {
            return (int)(((($n == 1 || $n == 11) ? 0 : ($n == 2 || $n == 12)) ? 1 : ($n > 2 && $n < 20)) ? 2 : 3);
        },
        12 => function ($n) {
            return (int)($n % 10 != 1 || $n % 100 == 11);
        },
        13 => function ($n) {
            return (int)($n !== 0);
        },
        14 => function ($n) {
            return (int)(((($n == 1) ? 0 : ($n == 2)) ? 1 : ($n == 3)) ? 2 : 3);
        },
        15 => function ($n) {
            return (int)(($n % 10 == 1 && $n % 100 != 11 ? 0 : $n % 10 >= 2 && ($n % 100 < 10 || $n % 100 >= 20)) ? 1 : 2);
        },
        16 => function ($n) {
            return (int)(($n % 10 == 1 && $n % 100 != 11 ? 0 : $n !== 0) ? 1 : 2);
        },
        17 => function ($n) {
            return (int)($n == 1 || $n % 10 == 1 ? 0 : 1);
        },
        18 => function ($n) {
            return (int)(($n == 0 ? 0 : $n == 1) ? 1 : 2);
        },
        19 => function ($n) {
            return (int)((($n == 1 ? 0 : $n === 0 || ($n % 100 > 1 && $n % 100 < 11)) ? 1 : ($n % 100 > 10 && $n % 100 < 20)) ? 2 : 3);
        },
        20 => function ($n) {
            return (int)(($n == 1 ? 0 : ($n === 0 || ($n % 100 > 0 && $n % 100 < 20))) ? 1 : 2);
        },
        21 => function ($n) {
            return (int)((($n % 100 == 1 ? 1 : $n % 100 == 2) ? 2 : $n % 100 == 3 || $n % 100 == 4) ? 3 : 0);
        },
        22 => function ($n) {
            return (int)((($n === 1 ? 0 : $n === 2) ? 1 : ($n < 0 || $n > 10) && $n % 10 == 0) ? 2 : 3);
        }
    ];
}

/**
 * Create plural rules
 *
 * @return array
 */
function createRules() {
    $rules = [];
    $rPluralTypes = getRulesForPluralTypes();
    foreach (SETS as $set) {
        foreach ($set['lngs'] as $l) {
            $rules[$l] = [
                'numbers'   =>  $set['nr'],
                'plurals'   =>  $rPluralTypes[$set['fc']]
            ];
        }
    }

    return $rules;
}

/**
 * Class PluralResolver
 *
 * Resolves plurals required based on rules specified above
 *
 * @package Pkly\I18Next
 */
class PluralResolver {
    /**
     * @var array
     */
    private $_options                           =   [];

    /**
     * @var LoggerInterface|null
     */
    private $_logger                            =   null;

    /**
     * @var LanguageUtil|null
     */
    private $_languageUtils                     =   null;

    /**
     * @var array
     */
    private $_rules                             =   [];

    /**
     * PluralResolver constructor.
     *
     * @param LanguageUtil $languageUtils
     * @param array $options
     * @param LoggerInterface|null $logger
     */
    public function __construct(LanguageUtil &$languageUtils, array $options = [], ?LoggerInterface $logger = null) {
        $this->_languageUtils = &$languageUtils;
        $this->_options = $options;

        if ($logger === null)
            $logger = new NullLogger();

        $this->_logger = $logger;

        $this->_rules = createRules();
    }

    /**
     * Add a new rule for language code
     *
     * @param string $lng
     * @param array $obj
     */
    public function addRule(string $lng, array $obj) {
        $this->_rules[$lng] = $obj;
    }

    /**
     * Get rules for a language code
     *
     * @param string $code
     * @return array|null
     */
    public function getRule(string $code): ?array {
        return $this->_rules[$code] ?? $this->_rules[$this->_languageUtils->getLanguagePartFromCode($code)] ?? null;
    }

    /**
     * Check if a plural is needed for language code
     *
     * @param string $code
     * @return bool
     */
    public function needsPlural(string $code): bool {
        $rule = $this->getRule($code);

        return count($rule['numbers'] ?? []) > 1;
    }

    /**
     * Get wanted forms for plurals for a language code and key
     *
     * @param string $code
     * @param string|null $key
     * @return array
     */
    public function getPluralFormsOfKey(string $code, ?string $key) {
        $rule = $this->getRule($code);

        if (!$rule)
            return [];

        $ret = [];

        foreach ($rule['numbers'] as $n) {
            $suffix = $this->getSuffix($code, $n);
            $ret[] = $key . $suffix;
        }

        return $ret;
    }

    /**
     * Get suffix for language for count
     *
     * @param string $code
     * @param $count
     * @return string
     */
    public function getSuffix(string $code, $count): string {
        $rule = $this->getRule($code);

        if ($rule) {
            $idx = call_user_func($rule['plurals'], abs($count));
            $suffix = $rule['numbers'][$idx];

            // special treatment for lngs only having singular and plural
            if (($this->_options['simplifyPluralSuffix'] ?? true) && count($rule['numbers']) === 2 && $rule['numbers'][0] === 1) {
                if ($suffix === 2)
                    $suffix = 'plural';
                else if ($suffix === 1)
                    $suffix = '';
            }

            if (($this->_options['simplifyPluralSuffix'] ?? true) && count($rule['numbers']) === 2 && $rule['numbers'][0] === 1)
                return ($this->_options['prepend'] ?? '') . $suffix;

            return ($this->_options['prepend'] ?? '') . $idx;
        }

        $this->_logger->warning('No plural rule found for '.$code);
        return '';
    }
}