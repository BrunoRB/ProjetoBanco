<?php

require_once 'main.php';

class Page_Convite extends Main {
	public function __construct() {
		$this->setTitle('Convites');
		parent::__construct();
	}

} new Page_Convite();