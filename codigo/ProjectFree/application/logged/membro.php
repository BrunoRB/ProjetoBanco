<?php

require_once 'main.php';

class Page_Membro extends Main {
	public function __construct() {
		$this->setTitle('Membros');
		parent::__construct();
	}
	
	protected function extraFunctionOnListar() {
		?>
		<br><br><br><br><br>
		Convidar membro: 
		<input data-type="text-autocomplete-membros" type="text" />
		<?php
	}
	
	protected function getListaDeMembros() {
	}

} new Page_Membro();