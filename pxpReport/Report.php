<?php
require_once(dirname(__FILE__).'/DataSource.php');
    class Report {
    	
		private $orientation = "";
		private $paper = "";
		private $components = array();
		private $dataSource;
		
		public function setOrientation($orientation) {
			$this->orientation = $orientation;
		}
		
		public function getOrientation() {
			return $this->orientation;
		}
		
		public function setPaper($paper) {
			$this->paper = $paper;
		} 
		
		public function getPaper() {
			return $this->paper;
		}
		
		public function setDataSource(DataSource $dataSource) {
			$this->dataSource = $dataSource;
		}
		
		public function getDataSource() {
			return $this->dataSource;
		}
		
		public function add(Component $component) {
			$this->components[] = $component;
		}
		
    }
?>