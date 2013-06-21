<?php

include_once '../templates/body.php';

class Index extends Body {
	public function __construct() {
		$this->setTtile('Home');
		parent::__construct();
	}

	public function loadBody() {
			?>
		<div id="container">
			<div class="pagination-right">
				<strong>100% Gratuito !
				Sua satisfação é nosso lucro.
				</strong>
			</div>

			<div class="pagination-centered verticalCenter">
				<h2>Gerenciamento de projetos de software de um modo como você nunca viu.</h2>
		    	<a href="login.php"><button type="button" class="btn btn-info btn-large">Faça login</button></a>
				<a href="cadastro.php"><button type="button" class="btn btn-info btn-large">Realize seu cadastro</button></a>
			</div>

		</div>
		<?php
	}

} new Index();