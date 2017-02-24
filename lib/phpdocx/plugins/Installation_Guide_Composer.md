If you're using any framework that work with composer as Symfony2, Yii or Laravel, you can follow these steps to use phpdocx:
   
1) Extract the package to the vendor/phpdocx folder.

2) Add this line in the autoload option of your composer.json:

    "files": [
        "vendor/phpdocx/Classes/Phpdocx/Create/CreateDocx.inc"
    ]

3) Update the composer autoloader:

php composer.phar dump-autoload

4) You can use the library:

    $docx = new \Phpdocx\Create\CreateDocx();
    $docx->addText('This is a test');
    $docx->createDocx('Sample');