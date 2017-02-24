<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('Arc:');

$options = array('width' => 70,
		       'height' => 70,
		       'fillcolor' => '#555555',
		       'strokecolor' => '#ff0000',
		       'strokeweight' => '4',
		       'startAngle' => 0,
		       'endAngle' => 210);

$docx->addShape('arc', $options);

$docx->addText('Curve:');

$options = array('from' => '300,40',
			'to' => '120,150',
			'fillcolor' => '#555555',
			'strokecolor' => '#ff0000',
			'strokeweight' => '4',
			'control1' => '60,70',
			'control2' => '125,170');

$docx->addShape('curve', $options);

$docx->addText('Line:');

$options = array('from' => '10,10',
			 'to' => '150,10',
			 'strokecolor' => '#0000ff',
			 'strokeweight' => '2',
			 'position' => 'absolute',
			 'margin-left' => 20);

$docx->addShape('line', $options);

$docx->addText('Polyline:');

$options = array('points' => '10,10 20,20 25,10 40,7 3,55',
			'strokecolor' => '#ff00ff',
			'strokeweight' => '2',
			'position' => 'absolute',
			'marginLeft' => 40,
			);

$docx->addShape('polyline', $options);

$docx->addBreak();

$docx->addText('Rectangle:');

$options = array('width' => 60,
			'height' => 20,
			'strokecolor' => '#ff00ff',
			'strokeweight' => '3',
			'fillcolor' => '#ffff00',
			'position' => 'absolute',
			'marginLeft' => 10,
			'marginTop' => -5);

$docx->addShape('rect', $options);

$docx->addText('Rounded rectangle:');

$options = array('width' => 60,
			 'height' => 30,
			 'strokecolor' => '#ff00ff',
			 'strokeweight' => '3',
			 'fillcolor' => '#ffff00',
			 'position' => 'absolute',
			 'marginLeft' => 60,
			 'marginTop' => 2,
			 'arcsize' => 0.3);

$docx->addShape('roundrect', $options);

$docx->addBreak();

$docx->addText('Arbitrary shape:');

$options = array('path' => 'm,118hdc80,65,159,24,252,v33,11,66,24,100,34c374,41,413,29,419,51v30,109,-6,
202,-100,234c308,296,299,311,285,318v-31,16,-100,34,-100,34c140,341,
92,339,51,318,33,309,20,288,17,268,14,251,34,218,34,218hal,118hdxe',
			'width' => 40,
			'height' => 40,
			'strokecolor' => '#000000',
			'strokeweight' => '2',
			'fillcolor' => '#ff0000',
			'position' => 'absolute',
			'marginLeft' => 5,
			'marginTop' => 0);

$docx->addShape('shape', $options);


$docx->addText('The same arbitrary shape but with negative z-index and a negative margin-top so it is drawn behind this text.');

$options = array('path' => 'm,118hdc80,65,159,24,252,v33,11,66,24,100,34c374,41,413,29,419,
51v30,109,-6,202,-100,234c308,296,299,311,285,318v-31,16,-100,34,-100,
34c140,341,92,339,51,318,33,309,20,288,17,268,14,251,34,218,34,218hal,118hdxe',
			'width' => 50,
			'height' => 50,
			'strokecolor' => '#dddddd',
			'strokeweight' => '2',
			'fillcolor' => '#ffff00',
			'position' => 'absolute',
			'marginLeft' => 25,
			'marginTop' => -45,
			'z-index' => -1000);

$docx->addShape('shape', $options);

$docx->addBreak();

$docx->addText('An oval with no fill color and a circle with yellow color:');

$options = array('width' => 100,
			'height' => 60,
			'strokecolor' => '#000000',
			'strokeweight' => '2');

$docx->addShape('oval', $options);

$options = array('width' => 100,
			'height' => 100,
			'strokecolor' => '#000000',
			'strokeweight' => '2',
			'fillcolor' => '#ffff00',
			'position' => 'absolute',
            'marginTop' => -75,
			'marginLeft' => 150);

$docx->addShape('oval', $options);


$docx->createDocx('example_addShape_1');