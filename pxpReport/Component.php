<?php
require_once 'Position.php';
    class Component {
    	private $position;
		
		public function __construct() {
			$this->position = new Position(0, 0);
		}
		
		public function setPosition(Position $position) {
			$this->position = $position;
		}
		
		public function getPosition() {
			return $this->position;
		}
    }
?>