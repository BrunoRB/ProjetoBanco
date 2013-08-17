<?php

require_once $_SERVER['DOCUMENT_ROOT'] . 'ProjectFree/core/body.php';

class Main extends Body {

	public function __construct() {
		$this->setExtraHeader('<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/logged.css" />');
		parent::__construct();
	}
}