<?php

require_once 'main.php';

class Page_Artefato extends Main {
	public function __construct() {
		$this->setTitle('Artefato');
		parent::__construct();
	}

	protected function novo(array $campos = array()) {
		$gerente = 'nome,tipo,descricao,porcentagem_concluida';
		parent::novo(array('gerente' => $gerente));
	}

} new Page_Artefato();