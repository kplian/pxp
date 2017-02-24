<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$comment = new WordFragment($docx, 'document');

$comment->addComment(
    array(
        'textDocument' => 'comment',
        'textComment' => 'The comment we want to insert.',
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

$docx->createDocx('example_addComment_1');