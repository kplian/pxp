<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateVariables.docx');

//first we remove the whole pragraph the contains the 'FOOTERVAR' variable
$docx->removeTemplateVariable('FOOTERVAR', 'block', 'footer');
//now we only remove the 'OTHERVAR' variable value
$docx->removeTemplateVariable('OTHERVAR', 'inline');
//and to finish remove the line containing the FOOTNOTEVAR variable in the footnote
$docx->removeTemplateVariable('FOOTNOTEVAR', 'block', 'footnote');

$docx->createDocx('example_removeTemplateVariable_1');
