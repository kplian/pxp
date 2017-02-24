<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('Some examples that illustrate how to inclueded tabbed text in your Word document:');

//first example
$tabs = array();
$tabs[] = array('position' => 2000);
$tabs[] = array('position' => 4000);
$tabs[] = array('position' => 6000);

$options = array('tabPositions' => $tabs);

$text = array();
$text[] = array('text' => 'one');
$text[] = array('text' => 'two', 'tab' => true);
$text[] = array('text' => 'three', 'tab' => true);

$docx->addText($text, $options);

//second example
$tabs = array();
$tabs[] = array('position' => 1000);
$tabs[] = array('position' => 3000);
$tabs[] = array('type' => 'center', 'leader' => 'dot', 'position' => 4000);

$options = array('tabPositions' => $tabs);

$text = array();
$text[] = array('text' => 'one');
$text[] = array('text' => 'two', 'tab' => true);
$text[] = array('text' => 'three', 'tab' => true);

$docx->addText($text, $options);

//third example
$tabs = array();
$tabs[] = array('position' => 1500);
$tabs[] = array('position' => 5000);
$tabs[] = array('type' => 'center', 'leader' => 'dot', 'position' => 7000);

$options = array('tabPositions' => $tabs);

$text = array();
$text[] = array('text' => 'one', 'tab' => true);
$text[] = array('text' => 'two', 'tab' => true);
$text[] = array('text' => 'three', 'tab' => true);

$docx->addText($text, $options);

$docx->createDocx('example_addText_4');