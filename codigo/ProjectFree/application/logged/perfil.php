<?php

require_once 'main.php';

class Page_Perfil extends Main {
	public function __construct() {
		$this->setTitle('Perfil');
		parent::__construct();
	}
	
	protected function listar() {
		$this->renderCadastrar = false;
		parent::listar();
	}
	

} new Page_Perfil();