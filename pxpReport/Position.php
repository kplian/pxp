<?php
    class Position {
    	
		private $x;
		private $y;
		private $z;
		
		public function __construct($x, $y) {
			$this->x = $x;
			$this->y = $y;
		}
		
		public function setX($x) {
			$this->x = $x;
		}
		
		public function getX() {
			return $this->x;
		}
		
		public function setY($y) {
			$this->y = $y;
		}
		
		public function getY() {
			return $this->y;
		}
    }
?>