<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateWordFragment_2.docx');

//create the Word fragment that is going to replace the variable
//like the variable to replace is in a footnote we should it as target
$wf = new Phpdocx\Elements\WordFragment($docx, 'footnote');

//create an image fragment
$image = new Phpdocx\Elements\WordFragment($docx, 'footnote');
//Warning: you can not poition absolutely  images in footnotes. That is a limitation of the Word interface not the standard.
$image->addImage(array('src' => '../../img/image.png' , 'scaling' => 10));
//and also a link fragment
$link = new Phpdocx\Elements\WordFragment($docx, 'footnote');
$link->addLink('link to Google', array('url'=> 'http://www.google.es', 'color' => '0000FF', 'u' => 'single'));

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
'text' => ' to illustrate how to include links in a footnote. '
);
$text[] =
array(
'text' => ' As you may see it is extremely simple to do so and can be done with any other Word element.',
);

//insert all the content in the Word fragment we are going to use for replacement
$wf->addText($text);
//we want to preserve the reference mark so we do an inline substitution to presereve the paragraph structure.
//we also target the footnote that is where the placeholder variable is located
$docx->replaceVariableByWordFragment(array('INLINEFRAGMENT' => $wf), array('type' => 'inline', 'target' => 'footnote'));


$docx->createDocx('example_replaceVariable ByWordFragment_2');
