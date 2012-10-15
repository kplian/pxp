<?php

class ACTColeccion implements Iterator {

   private $_items = null;

   public function __construct() {
      $this->_books = array();
   }

   public function addItem($i){
      $this->_items[] = $i;
   }

   public function removeItem($i){
      unset($this->_items[array_search($i, $this->_items)]);
   }

   public function rewind() {
       reset($this->_items);
   }

   public function current() {
       return current($this->_items);
   }

   public function key() {
       return key($this->_items);
   }

   public function next() {
       return next($this->_items);
   }

   public function valid() {
       return $this->current() !== false;
   }

}


?>