<?php

require_once 'main.php';

class Page_Sobre extends Main {
	public function __construct() {
		$this->setTitle('Sobre');
		parent::__construct();
	}
	
	protected function listar() {
		?>
		<h2>
			Projectfree, sistema colaborativo para gerenciamento de projetos
		</h2>
		<?php 
	}
	

} new Page_Sobre();