====PHPdocX 5.0 by 2mdc.com====
http://www.phpdocx.com/

PHPDOCX is a PHP library designed to dynamically generate reports in Word format (WordprocessingML).

The reports may be built from any available data source like a MySQL database or a spreadsheet. The resulting documents remain fully editable in Microsoft Word (or any other compatible software like OpenOffice) and therefore the final users are able to modify them as necessary.

The formatting capabilities of the library allow the programmers to generate dynamically and programmatically all the standard rich formatting of a typical word processor.

This library also provides an easy method to generate documents in other standard formats such as PDF or HTML.

====What's new on PHPdocX 5.0?====

XML Api: An API for document generation without PHP knowledge. Its easy tagging allows to access the phpdocx methods as well as working with templates. This feature doesn´t require any programming skills. Only available for Corporate and Enterprise licenses.

Logger: Phpdocx runs an inside logger. From version 5.0 on, phpdocx allows to use a custom logger that complies with the PSR-3 Logger interface.

4.6 VERSION

This new version adds support to generate and transform the Table of contents (TOC) when using the conversion plugin, replaces placeholder in headers and footers by WordFragments and adds a new option to solve the CVE-2014-2056 vulnerability.

4.5 VERSION

This version includes a new conversion plugin that uses LibreOffice as the transformation tool. It doesn't need OdfConverter to transform the documents.

Both LibreOffice and OpenOffice suites are supported.

The Corporate and Enterprise licenses include plugins to use phpdocx with Drupal, WordPress, Symfony and any framework or development that use composer.

4.1 VERSION

This new version adds support for charts when the documents are transformed to PDF (using JpGraph http://jpgraph.net or Ezcomponents http://ezcomponents.org) and a new package that includes namespaces support.

The namespaces package is only available for Corporate and Enterprise licenses.

4.0 VERSION

This new major version represents a big step forward regarding the functionality and scope of PHPDocX.

The most important change introduced in this new version is that it removes all the restrictions regarding custom templates that were limitating previous versions.

With PHPDocX 4.0 one may use concurrently the standard template methods of the past (that have also been improved and refactored) with any of the core PHPDocX methods. This means in practice that one is not limited to modify the contents of a custom by simply replacing variables but that one may insert arbitrary Word content anywhere within the template.

Another important new feature is the introduction of "Word fragments" that allow for a simpler and more flexible creation of content. One may create a Word fragment with arbitrary content: paragraphs, lists, charts, images, footnote, etcetera and later insert it anywhere in the Word document in a truly simple and transparent way.

The main changes can be summarized as follows:

CORE AND TEMPLATES:
      * Completely refactored CreateDocx class and a completely new CreateDocxFromTemplate class that extends the former and allows for a complete control of documents based on custom templates.
      * New WordFragment class that greatly simplifies the process of nesting content within the Word document.
      * Complete refactoring of the prior template methods that allow for higher control and the replacement of variables by arbitrarily complex Word fragments.
      * createListStyle: greater choice of options for the creation of custom list styles.
      * addTextBox: includes now new formatting options and it is easier to include arbitrary content within textboxes.
      * insertWordFragmentBefore/After: allows to include content anywhere within a Word template.

DOCX UTILITIES PACKAGE
      * MultiMerge: much faster API that allows for the merging of an arbitrarily large number of Word documents with just
      one line of code.
 
CONVERSION PLUGIN
     * The conversion of numbered lists has been greatly improved as weell as the handling of sections with multiple columns.

Besides these new classes and methods we have also included some minor bug fixes and multiple improvements in the API including extra options and a uniformization the typing and units conventions.

3.7 VERSION

The main goal of this version is to allow for the generation of "right to left language" (like, for example, Arabic or Hebrew) Word documents with PHPDocX.

It is now possible to set up global RTL properties that affect the whole document or to stablish them for just some particular elements like paragraphs, tables, etcetera.

The following methods/classes/files have been added or modified:

CORE:
      * phpdocxconfig.ini now admits to new global options: bidi and rtl.
      * setRTL: allows to set global RTL properties for a particular document.
      * embedHTML: now the HTML parser supports HTML and CSS standard RTL options.
      * The following methods allow for rtl options:
               * addSection
               * modifyPageLayout
               * addDateAndHour
               * addEndnote
               * addFootnote
               * addFormElement
               * addLink
               * addMergeField
               * modifyPageLayout
               * addPageNumber
               * addSimpleField
               * addStructuredDocumentTag
               * addTable
               * addTableContents
               * addSection
               * addText
        * createListStyle: allows now to use custom fonts for bullets.

DOCX UTILITIES PACKAGE
      * The merging includes some improvements for images included within shapes.

CONVERSION PLUGIN
     * There is a new debugging mode to simplify the installation process.

3.6 VERSION

CORE:
      * addMergeField: it is now posible to include standard Microsoft Word merge fields. Although PHPDocx has its own protocols for the substitution of variables several of our clients have requested this feature to allow further manipulations in Microsoft Office with the generated docx files.
      * modifyInputField: together with the tickCheckbox method allows to fulfill forms integrated in a template.

DOCX UTILITIES PACKAGE
      * It is now possible to enforce section page breaks when merging documents even when the original documents have continuous section types
 
CONVERSION PLUGIN
     * We have included extra preprocessing of the documents prior to conversion to improve table rendering.

The package now includes an improved version of check.php that outputs info useful to debug any issue or problem related to the license or the library.

3.5.1 VERSION

This minor version includes:
    * New version of check.php script that includes license info and better guidance for the installation of the conversion plugin.
    * Improvements in the PDF conversion plugin.
    * Several improvements for the embedding of HTML into Word.
    * Minor bug fixes.

3.5 VERSION

This version includes several changes that greatly improve the core functionality of PHPDocX and in particular the conversion of HTML into Word.

CORE:
      * addComment: it is now posible to include Word comments that may incorporate complex formatting as well as images and HTML content. It is also posible to fully customize the comment properties and reference marks.
      * addFotnote and addEndnote: these methods have been completely refactored to leverage their capabilities to the new addComment method, therefore it is now posible to create truly sophisticated endnotes and footnotes.
      * createListStyle: one may now create fully customized list styles that may be used directly in conjunction with the addList method or  with the embedHTML/replaceTemplateVariable BYHTML methods (seee below).
      * createParagraphStyle: simplify your coding creating reusable custom paragraph styles that incorporate multiple formatting options (practically the full standard).
      * lineNumbering: it is posible now to insert customized line numbering in your Word document.
      * addPageBorders: its name explains it all (custom border types, colors, width, ...).
      * addText: it is now posible to customize paragraph hanging properties and indent the first line of text.
      * addMathMML: refactored to include inline math equations.

HTML2DOCX
      * 'useCustomLists' option: it allows to mimic sophisticated CSS list styles with PHPDocX. One should create first a custom list style via the createListStyle method with the same name as the CSS style that one wants to reproduce and if this option is set to true the corresponding Word list style will be used.
      * General improvements in the format rendering of list elements and table cells (in particular with sophisticated row and colspan layouts).

DOCX UTILITIES PACKAGE
      * setLineNumbering: allows for the modification of the line numbering properties of an existing Word document.
 
CONVERSION PLUGIN
     * New integrated versions of ODFConverter for Linux 64-bit OS and Windows.

3.3 VERSION

This new version includes some changes that greatly improve the PHPDocX functionality. There are several brand new methods:

CORE:
      * addSimpleField: allows for the insertion of standard Word fields in the body of the document sucha as the number of pages, document title, author, creation date, etecetera.
      * addHeading: to insert standard Word headings that may be directly included in the Table of Contents.
      * docxSettings: this method allows you to modify many of the general properties of a Word document such as the zoom on openning, the printing options, to show or hide grammar and spelling, etcetera.

TEMPLATE MANAGEMENT
      * tickCheckbox: one may now tag standard Word checkboxes in a given template and later change theirs state with the help of this useful method.

DOCX UTILITIES PACKAGE
      * modifyDocxSettings: allows for the modification of the general properties of a given pre-existing Word document. One may, for example, change the zoom properties on openning of all the documents contained in a folder with a few lines of PHP code.
      * parseCheckboxes: With the help of this method one may tick or not all the checkboxes of a given pre-existing Word document.

Besides these new methods we have improved previously existing functionality:
      * embedHTML: we improved the management of CSS page break properties and HTML line breaks.
      * addDocx: we have included the OOXML "matchSource" property to improve the rendering of embedded docx document when there are conflicting styles.
      * addTemplateVariable: we have "removed the extra empty line" that was added when replacing a template variable by a DOCX, HTML, MHT or RTF file.
      * Minor bug fixes.

We have also restructured the API documentation to simplify the access to relevant information. We have also included in the v3.3 package a refined version of  the "installation script" that now checks not only for the PHP modules required by PHPDocX but also permission rights as well as the correct installation of the PDF conversion plugin (both via web or CLI).

3.2 VERSION

This version includes some important changes that greatly improve the PHPDocX functionality:

- It is now possible to create really sophisticated tables that practically covered all posibilities offered by Word:
      * arbitrary row and column spans,
      * advanced positioning: floating, content wrapping, ...,
      * custom borders at the table, row or cell level (type, color and width),
      * custom cell paddings and border spacings,
      * text may be fitted to the size of a cell,
      * etcetera 
- There are several brand new methods:
      * addStructuredDocumentTags: that allows for the insertion of combo boxes, date pickers, dropdown menus and richtext boxes,
      * addFormElement: to insert standard form elements like text fields, check boxes or selects,
      * cleanTemplateVariables: to remove unused PHPDocX template variables together with is container element (optional) from the resulting Word template.
- It is now posible to insert arbitrarily complex tabbed content into the Word document (tab positions, leader symbol and tab type).
- There is a new UTF-8 detection algorithm more reliable that the standard PHP one based on mb_detect_encoding
- There is a new external config file that will simplify future extensibility
 
Besides these improvements, PHPDocX v3.2 also offers:
- Minor improvements in the addText method: one may use the caps option to capitalize text and it is now easier to set the different paragraph margins.
- Minor bug fixes

3.1 VERSION

This new version includes quite a few new features that you may find interesting:

- It is now posible to insert arbitrary content within a paragraph with the updated addText method:
      * multiple runs of text with diverse formatting options (color, bold, size, ...)
      * inline or floating images and charts that may be carefully positioned  thanks to the new vertical and horizontal offset parameters
      * page numbers and current date
      * footnotes and endnotes
      * line breaks and column breaks
      * links and bookmarks
      * inline HTML content
      * shapes
- In general the new addText method accepts any inline WordML fragment. This will make trivial to insert new elements in paragraphs as they are integrated in PHPDocX.
- We have greatly improved the automatic generation of the table of Contents via the addTableContents method. One may now:
      * request automatic updating of the TOC on the first openning of the document (the user will be automatically prompted to update fields in the Word document)
      * limit the TOC levels that should be shown (the default value is all)
      * import the TOC formatting from an existing Word document
- The addTemplateImage has now more configuration options so it is no longer necessary to include a placeholder image with the exact size and dpi in the PHPDocX Word template. Moreover one can now use the same generic placehorder image for the whole document simplifying considerably the process.
- The logging framework has been updated to the latest stable version of log4php.
- You may now use an external script to transform DOCX into PDF using TransformDocAdv.inc class. This script fixes the problems related to runnig system commands using Apache or any other not CGI/FastCGI web server.

Besides these improvements v3.1 also offers:
- Minor improvements in the HTML to Word conversion: one may change the orientation of text within a table cell and avoid the splitting of a table row between pages.
- New configuration options for the addImage method
- Now it is simpler to link internal bookmarks with the addLink method
- When merging two Word documents one can choose to insert line breaks between them to clearly separate the contents
- One may import styles using also their id (this may simplify some tasks)
- Minor bug fixes

3.0 VERSION

This version includes substantial changes that have required that this new version were not fully backwards compatible with the latest v2.7.

Nevertheles the changes in the API are not difficult to implement in already existing scripts and the advantages are multiple.

The main changes are summarized as follows:

- The new version handles in a different way the embedding of Word elements within other elements like tables, lists and headers/footers. The 
majority of methods have now a 'rawWordML' option that in combination with the new 'createWordMLFragment' allows for the generation of chunks of 
WordMl code that can be inserted with great flexibility anywhere within the Word document. its is now, for example, trivial to include paragraphs, 
charts, tables, etcetera in a table cell.
-One may create sophisticated headers and footers with practically no restriction whatsoever by the use of the 'createWordMLFragment'  method.
-The embedHTML and replaceTemplateVariableByHTML have been improved to include practically all CSS styles and parse floats. It is also posible now 
to filter the HTML content via XPath expressions and associate different native Word styles to individual CSS classes, ids or HTML tags.
-New chart types have been included: scatter, bubbles, donoughts and the code has been refactor to allow for greater flexibility.
-The addsection method has been extended and improved.
-The addTextBox method has been greatly improved to include many more formatting options.
-The refactored addText method allows for the introduction of line breaks inside a paragraph.
-New addPageNumber method
-New addDateAndHour method

2.7 VERSION

The main differences with respect the prior stable major version PHPDocX v2.6 can be summarized as follows:

- New chart types: percent stacked bar and col charts and double pie charts (pie or bar chart for the second one)
- Improvements in the HTML parser (floating tables, new CSS properties implemented)
- Now is posible to insert watermarks (text and/or images)
- New CryptoPHPDocX class (only CORPORATE) that allos for password protected docuemnts
- Automatic leaning of temporary files
- New method: setColorBackgraound to modify the background color of a Word document
- Several other minor improvements and bug fixes

2.6 VERSION

The main improvements are:

New and more powerfull conversion plugin for PRO+ and CORPORATE packages.
New HTML parser engine for the embedding of HTML into Word: 20% faster and up to 50% less RAM consumption.
New HTML tags and properties parsed (now covering practically the whole standard):
 -HTML headings become true Word headings
 -Flaoting images are now embedded as floated images in Word
 -Anchors as parsed as links and bookmarks
 -Web forms are converted into native Word forms
 -Horizontal rulers are also parsed into Word
 -Several other minor improvements and bug fixes
New addParagraph method that allows to create complex paragraphs that may include:
 -Formatted text
 -Inline or floating images
 -Links
 -Bookmarks
 -Footnotes and endnotes
New addBookmark method
Improvements in the DocxUtilities class (only PRO+ and Corporate licenses): improved merging capabilities that cover documents with charts, images, footnotes, comments, lists, headers and footers, etcetera.

2.5.2 FREE VERSION
- Docx to TXT to convert Docx documents to pure text

2.5.2 PRO VERSION
- New format converter for Windows (MS Word must be installed)
- Now you can replace the image in headers
- New method DocxtoTXT to convert docx documents to pure text
- Better implementation of HTML to WORDML
- Bug fixes

2.5.1 PRO VERSION
One of the most demanded functionalities by PHPDocX users is the posibility to generate Word documents out of HTML retaining the format and construct documents with different HTML blocks. Now we give a little step to make this functionality more powerful.

Since the launch of the 2.5.1 version of PHPDocX we have at your disposal two new methods: embedHTML() and replaceTemplateVariableByHTML() - new on this version- that allow to convert HTML into Word with a high degree of customization.

Moreover this conversion is obtained by direct translation of the HTML code into WordProcessingML (the native Word format) so the result is fully compatible with Open Office (and all its avatars), the Microsoft compatibility pack for Word 2003 and most importantly with the conversion to PDF, DOC, ODT and RTF included in the library.

2.5 PRO VERSION
This version of PHPDocX includes several enhancements that will greatly simplify the generation of Word documents with PHP.
The main improvements can be summarized as follows:
- New embedHTML method that:
  o Directly translates HTML into WordProcessingXML.
  o Allows to use native Word Styles, i.e. we may require that the HTML tables are formatted following a standard Word table style.
  o Is compatible with OpenOffice and the Word 2003 compatibility pack.
  o May download external HTML pages (complete or selected portions) embedding their images into the Word document.

- PHPDocX v2.5.1 now uses base templates that allow:
  o To use all standard Word styles for:
    - Paragraphs.
    - Tables with special formatting for first and last rows and columns, banded rows and columns and another standard features.
    - Lists with several different numbering styles.
    - Footnotes and endnotes.
  o Include standard headings (numbered or not).
  o Include customized headers and footers as well as front pages.

- There are new methods that allow you to parse all the available styles of a Word document and import them into your base template:
  o parseStyles  generates a Word document with all the available styles as well as the required PHPDocX code to use them in your final Word document (you may download here the result of this method applied to the default PHPDocX base template).
  o importStyles allows to integrate new styles  extracted from an external Word document into your base template.

- New conversion plugin (based on OpenOffice) that improves the generation of PDFs, RTFs and legacy versions of Word documents.

- New standardized page layout properties (A4, A3, letter, legal and portrait/landscape modes) trough the new modifyPageLayout method.

- The addTemplate method has been upgraded to greatly improve its performance.

- You may directly import sophisticated headers and footers from an existing Word document with the new  importHeadersAndFooters method.

As well as many other minor fixes and improvements.
We have also upgraded our documentation section by simplifying the access to the available library examples and we have included a tutorial that will help newcomers to get grasp of the power of PHPDocX.

====What are the minimum technical requirements?====
To run PHPDocX you need to have a functional PHP setup, this should include:

- PHP 5
- Required : Support ZipArchive
- A webserver (such as Apache, Nginx or Lighttpd) or PHP-CLI