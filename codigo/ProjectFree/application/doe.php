<?php

require_once 'main.php';

class Page_Doe extends Main {
	public function __construct() {
		$this->setTitle('Doe');
		parent::__construct();
	}
	
	protected function listar() {
		?>
		<h2>
			<p>Ajude o Project Free continuar ajudando você nos seus projetos,
			sua ajuda é fundamental para que possamos continuar contribuindo com o bom desenvolvimento de softwares.</p> 
			<p>Doe qualquer valor. Obrigado.</p>
		</h2>
		<?php 
	}
	

} new Page_Doe();