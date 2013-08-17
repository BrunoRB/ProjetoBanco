<?php

require_once $_SERVER['DOCUMENT_ROOT'] . 'ProjectFree/util/Constants.php';

require_once ROOT_FOLDER . '/util/Util.php';

require_once ROOT_FOLDER . '/templates/header.php';
require_once ROOT_FOLDER . '/templates/footer.php';

class Body {

	public function __construct() {
		$this->init();
	}

	private function init() {
		Header::loadHead();
		$this->loadBody();
		Footer::loadFooter();
	}

	public function loadBody(){}


	public function setTitle($title) {
		Header::setTitle($title);
	}

	public function setExtraHeader($extraHeader) {
		Header::setExtraHeader($extraHeader);
	}

}
