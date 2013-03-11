<?php
require_once(dirname(__FILE__).'/Report.php');

Class ReportWriter {
	
	private $report;
	private $fileName;
	const PDF = 'pdf';
	
	function __construct(Report $report, $fileName) {
		$this->report = $report;
		$this->fileName = $fileName;
	}
	
	function setReport(Report $report) {
		$this->report = $report;
	}
	
	function getReport() {
		return $this->report;
	}
	
	function setFileName($fileName) {
		$this->fileName = $fileName;
	}
	
	function getFileName() {
		return $this->fileName;
	}
	
	function writeReport($reportType) {
		$this->report->write($this->fileName);
	}
}
?>