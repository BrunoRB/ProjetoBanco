<?php

require_once 'main.php';

class Page_FaleConosco extends Main {
	public function __construct() {
		$this->setTitle('Fale conosco');
		parent::__construct();
	}
	
	protected function listar() {
		?>
		<label>Nome: <small>*</small></label>
<input name="nome" size="53" type="text"><br class="clear">
<label>Email: <small>*</small></label>
<input name="email" size="53" type="text"><br class="clear">
<label>Assunto: <small>*</small></label>
<input name="assunto" size="53" type="text"><br class="clear">
		<label>Texto: <small>*</small></label>
<textarea name="assunto" data-type="text-multi"></textarea> <br>
<button class="btn btn-large btn-primary">Enviar</button>
		<?php 
	}
	

} new Page_FaleConosco();