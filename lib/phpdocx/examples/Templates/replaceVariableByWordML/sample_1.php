<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateWordML.docx');

//beware that this method does not take care of relationships and dependences
//so you have to make sure that the wordML is 'self-contained'
//we recommend to avoid this method unless one really knows the underlying OOXML standard
$wordML = '<w:p>
	<w:r>
		<w:t xml:space="preserve">This is a simple paragraph with some </w:t>
	</w:r>
	<w:r>
		<w:rPr>
			<w:b/>
		</w:rPr>
		<w:t>bold</w:t>
	</w:r>
		<w:r >
			<w:t xml:space="preserve"> text.</w:t>
	</w:r>
</w:p>';

$docx->replaceVariableByWordML(array('WORDML' => $wordML));


$docx->createDocx('example_replaceVariableByWordML_1');
