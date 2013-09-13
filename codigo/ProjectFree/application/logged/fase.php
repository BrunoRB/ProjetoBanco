<?php

require_once 'main.php';

class Page_Fase extends Main {
	public function __construct() {
		$this->setTitle('Fase');
		parent::__construct();
	}
	
	protected function novo(array $campos = array()) {
		$gerente = 'nome,descricao,fk_projeto,fk_predecessora';
		parent::novo(array('gerente' => $gerente));
	}

} new Page_Fase();