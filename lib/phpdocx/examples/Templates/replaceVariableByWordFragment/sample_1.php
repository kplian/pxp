<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateWordFragment_1.docx');

//create the Word fragment that is going to replace the variable
$wf = new Phpdocx\Elements\WordFragment($docx, 'document');

//create an image fragment
$image = new Phpdocx\Elements\WordFragment($docx, 'document');
$image->addImage(array('src' => '../../img/image.png' , 'scaling' => 50, 'float' => 'right', 'textWrap' => 1));
//and also a link fragment
$link = new Phpdocx\Elements\WordFragment($docx, 'document');
$link->addLink('link to Google', array('url'=> 'http://www.google.es', 'color' => '0000FF', 'u' => 'single'));
//and a footnote fragment
$footnote = new Phpdocx\Elements\WordFragment($docx, 'document');
$footnote->addFootnote(
	array(
		'textDocument' => 'here it is',
		'textFootnote' => 'This is the footnote text.',
	)
);
//combine them to create a paragraph
$text = array();

$text[] = $image;
$text[] =
array(
'text' => 'I am going to write a link: ',
'b' => 'on'
);
$text[] =$link;
$text[] =
array(
'text' => ' to illustrate how to include links. '
);
$text[] =
array(
'text' => ' As you may see is extremely simple to do so and can be done with any other Word element. For example to include  a footnote is also as simple as this: ',
);
$text[] = $footnote;
$text[] =
array(
'text' => ' , as you see there is a footnote at the bootom of the page. ',
'color' => 'B70000'
);
//insert all the content in the Word fragment we are going to use for replacement
$wf->addText($text);

$docx->replaceVariableByWordFragment(array('WORDFRAGMENT' => $wf), array('type' => 'block'));


$docx->createDocx('example_replaceVariable ByWordFragment_1');
