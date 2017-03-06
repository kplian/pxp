<?php

return array(
    'rootLogger' => array(
        'appenders' => array('default'),
        'level' => 'warn'
    ),
    'appenders' => array(
        'default' => array(
            'class' => 'LoggerAppenderConsole',
            'layout' => array(
                'class' => 'LoggerLayoutSimple'
            )
        )
    )
);