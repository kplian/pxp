<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$footnote = new WordFragment($docx, 'document');

$html = new WordFragment($docx, 'footnote');//notice the different "target"

$htmlCode = '<p>This is some HTML code with a link to <a href="http://www.2mdc.com">2mdc.com</a> and a random image: 
<img src="../../img/image.png" width="35" height="35" style="vertical-align: middle"></p>';

$html->embedHTML($htmlCode, array('downloadImages' => true));


$footnote->addFootnote(
    array(
        'textDocument' => 'footnote',
        'textFootnote' => $html,
        'footnoteMark' => array('customMark' => '*')
    )
);
                    

$text = array();
$text[]= array('text' => 'Here comes the ');
$text[]= $footnote;
$text[]= array('text' => ' and some other text.');


$docx->addText($text);
$docx->addText('Some other text.');

$docx->createDocx('example_Footnote_2');

