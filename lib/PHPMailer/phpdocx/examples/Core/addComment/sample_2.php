<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$comment = new WordFragment($docx, 'document');

$html = new WordFragment($docx, 'comment');//notice the different "target"

$htmlCode = '<p>This is some HTML code with a link to <a href="http://www.2mdc.com">2mdc.com</a> and a random image: 
<img src="../../img/image.png" width="35" height="35" style="vertical-align: -15px"></p>';

$html->embedHTML($htmlCode, array('downloadImages' => true));


$comment->addComment(
    array(
        'textDocument' => 'comment',
        'textComment' => $html,
        'initials' => 'PT',
        'author' => 'PHPDocX Team',
        'date' => '10 September 2000'
    )
);
                    

$text = array();
$text[]= array('text' => 'Here comes the ');
$text[]= $comment;
$text[]= array('text' => ' and some other text.');


$docx->addText($text);

$docx->createDocx('example_addComment_2');

