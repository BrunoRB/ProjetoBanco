<?php

include_once '../templates/body.php';

class Home extends Body {

	public function __construct() {
		$this->setTtile('Home');
		parent::__construct();
	}

	public function loadBody() {
		?>
			<div class="pull-right white">Bem vindo xxx</div>
		<?php
	}

} new Home();