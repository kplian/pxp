<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//create a Word fragment with an image
$image = new Phpdocx\Elements\WordFragment($docx);
$imageOptions = array(
    'src' => '../../img/image.png',
    'scaling' => 50, 
    'float' => 'right',
    'textWrap' => 1 
    );
$image->addImage($imageOptions);

//create a Word fragment with a link
$link = new Phpdocx\Elements\WordFragment($docx);
$linkOptions = array('url'=> 'http://www.google.es', 
    'color' => '0000FF', 
    'underline' => 'single');
$link->addLink('link to Google', $linkOptions);

//create a Word fragment with a footnote
$footnote = new Phpdocx\Elements\WordFragment($docx);
$footnote->addFootnote(
    array(
        'textDocument' => 'here it is',
        'textFootnote' => 'This is the footnote text.',
    )
);

//now we insert the different runs of text with created content and some text
$text = array();

$text[] = $image;
$text[] = array(
    'text' => 'I am going to write a link: ',
    'bold' => true
    );
$text[] = $link;
$text[] =array(
    'text' => ' to illustrate how to include links. '
    );
$text[] = array(
    'text' => ' As you may see it is extremely simple to do so and it can be done with any other Word element. For example to include  a footnote is also as simple as this: ',
    );
$text[] = $footnote;
$text[] = array(
    'text' => ' , as you may check there is a footnote at the bootom of the page. ',
    'color' => 'B70000'
    );

$docx->addText($text);

$docx->createDocx('example_addText_3');