<?php

require_once 'main.php';

class Page_Fase extends Main {
	public function __construct() {
		$this->setTitle('Fase');
		parent::__construct();
	}

} new Page_Fase();