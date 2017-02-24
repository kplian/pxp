OpenXML/ODF Translator Command Line Tool
========================================

Thank you for downloading the OpenXML/ODF Translator Command Line Tool.

The command line tool enables you to convert documents between the OpenDocument Format (ODF) and Office OpenXML (ECMA). For more details and future updates on the project, please see the project website hosted on SourceForge: http://odf-converter.sourceforge.net/.

Funded by Microsoft the OpenXML/ODF Translator has been developed by Clever Age, Aztecsoft, Sonata and DIaLOGIKa.


Software Requirements
---------------------
To execute the program, you need the Microsoft .NET Framework 2.0 (http://www.microsoft.com/downloads/details.aspx?familyid=0856eacb-4362-4b0d-8edd-aab15c5e04f5&displaylang=en) installed on your computer.

Please make sure all recommended Windows updates are installed. Especially the installation of .NET Framework 2.0 Service Pack 1 is highly recommended.


Usage
-----

Usage: OdfConverter.exe /I PathOrFilename [/O PathOrFilename] [/<OPTIONS>]

  Where options are:
     /I PathOrFilename  Name of the file to transform (or input folder in case of batch conversion)
     /O PathOrFilename  Name of the output file (or output folder)
     /F                 Overwrite existing file(s)
     /V                 Validate the result of the transformation against the schemas
     /P                 Show conversion progress on the command line
     /REPORT Filename   Name of the report file that should be generated (existing files will be replaced)
     /LEVEL Level       Level of reporting: 1=DEBUG, 2=INFO, 3=WARNING, 4=ERROR
     
  Batch options (use one of the /BATCH-<format> options at a time):
     /BATCH-ODT         Do a batch conversion over every ODT file in the input folder (Note: use /F to replace existing files)
     /BATCH-DOCX        Do a batch conversion over every DOCX file in the input folder (Note: use /F to replace existing files)
     /BATCH-ODP         Do a batch conversion over every ODP file in the input folder (Note: use /F to replace existing files)
     /BATCH-PPTX        Do a batch conversion over every PPTX file in the input folder (Note: use /F to replace existing files)
     /BATCH-ODS         Do a batch conversion over every ODS file in the input folder (Note: use /F to replace existing files)
     /BATCH-XLSX        Do a batch conversion over every XLSX file in the input folder (Note: use /F to replace existing files)
     /R                 Process subfolders recursively during batch conversion
     
  Converion direction options (to disable automatic file type detection):
     /ODT2DOCX          Force conversion to DOCX regardless of input file extension
     /DOCX2ODT          Force conversion to ODT regardless of input file extension
     /ODS2XLSX          Force conversion to XLSX regardless of input file extension
     /XLSX2ODS          Force conversion to ODS regardless of input file extension
     /ODP2PPTX          Force conversion to PPTX regardless of input file extension
     /PPTX2ODP          Force conversion to ODP regardless of input file extension
     
  Developer options:
     /XSLT Path         Path to a folder containing XSLT files (must be the same as used in the lib)
     /NOPACKAGING       Don't package the result of the transformation into a ZIP archive (produce raw XML)
     /SKIP Name         Skip a post-processing (provide the post-processor's name)


Features Not Supported / Incompatibilities
------------------------------------------

For a complete list of unsupported features see our web site at http://odf-converter.sourceforge.net/features.html. 
