<?php

include_once 'header.php';
include_once 'footer.php';

class Body {
	private $title;

	public function __construct() {
		$this->init();
	}

	private function init() {
		Header::loadHead($this->getTitle());
		$this->loadBody();
		Footer::loadFooter();
	}

	public function loadBody(){

	}

	public function getTitle() {
		return $this->title;
	}

	public function setTtile($title) {
		$this->title = $title;
	}
}
