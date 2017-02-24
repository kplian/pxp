<?php
namespace Team2mdc\PhpdocxBundle\Classes;

require_once(dirname(__FILE__) . "/../src/lib/pdf/tcpdf/tcpdf.php");

class TcpdfBridge
{
	private $pageOrientation = 'P';
	private $unit = 'mm';
	private $pageFormat = 'A4';
	private $unicode = true;
	private $encoding = 'UTF-8';
	private $diskcache = false;
	private $pdfa = false;

	public function __construct($options = array()) 
	{
		if (isset($options['pageOrientation'])) {
			$this->pageOrientation = $options['pageOrientation'];
		}
		if (isset($options['unit'])) {
			$this->unit = $options['unit'];	
		}
		if (isset($options['pageFormat'])) {
			$this->pageFormat = $options['pageFormat'];
		}
		if (isset($options['unicode'])) {
			$this->unicode = $options['unicode'];
		}
		if (isset($options['encoding'])) {
			$this->encoding = $options['encoding'];
		}
		if (isset($options['diskcache'])) {
			$this->diskcache = $options['diskcache'];
		}
		if (isset($options['pdfa'])) {
			$this->pdfa = $options['pdfa'];
		}
	}

	public function createTcpdf() 
	{
		return new \TCPDF();
	}
}