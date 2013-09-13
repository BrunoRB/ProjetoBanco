<?php

require_once 'main.php';

class Page_Membro extends Main {
	public function __construct() {
		$this->setTitle('Membros');
		parent::__construct();
	}
	
	protected function listar() {
		$this->renderCadastrar = false;
		parent::listar();
	}
	
	protected function extraFunctionOnListar() {
		?>
		Convidar membro: 
		<input data-type="text-autocomplete-membros" type="text" /> <br>
		<button class="btn btn-large btn-primary">Convidar</button>
		<?php
	}
	
	protected function getListaDeMembros() {
	}

} new Page_Membro();