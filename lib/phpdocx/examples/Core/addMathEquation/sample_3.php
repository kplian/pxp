<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We write a math equation using MathMML:');

$mathML = '<math xmlns="http://www.w3.org/1998/Math/MathML">
	<mrow>
		<mi>A</mi> 
		<mo>=</mo>
		<mfenced open="[" close="]">
			<mtable>
				<mtr>
					<mtd>
						<mi>x</mi>
					</mtd> 
					<mtd>
						<mn>2</mn>
					</mtd>
				</mtr>
				<mtr>
					<mtd>
						<mn>3</mn>
					</mtd>
					<mtd>
						<mi>w</mi>
					</mtd>
				</mtr>
			</mtable>
		</mfenced>
	</mrow>
</math>';

$docx->addMathEquation($mathML, 'mathmml');

$text = array();
$text[] = array('text' => 'The same equation inline: ');
$math = new Phpdocx\Elements\WordFragment($docx);
$math->addMathEquation($mathML, 'mathml');
$text[] = $math;

$docx->addText($text);

$docx->createDocx('example_addMathML_1');