<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$comment = new Phpdocx\Elements\WordFragment($docx, 'document');

$comment->addComment(
	array(
		'textDocument' => 'comment',
		'textComment'  => 'The comment we want to insert.',
		'initials'     => 'PT',
		'author'       => 'PHPDocX Team',
		'date'         => '10 September 2000',
	)
);

$text   = array();
$text[] = array('text' => 'Here comes the ');
$text[] = $comment;
$text[] = array('text' => ' and some other text.');

$docx->addText($text);

$docx->createDocx('example_addComment_1');