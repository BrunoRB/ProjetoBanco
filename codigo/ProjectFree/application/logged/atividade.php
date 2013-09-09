<?php

require_once 'main.php';

class Page_Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}

	protected function novo(array $campos = array()) {
		$gerente = 'inicio_atividade,limite_atividade,nome_atividade,descricao_atividade,fk_predecessora,fk_fase';
		parent::novo(array('gerente' => $gerente));
	}

} new Page_Atividade();