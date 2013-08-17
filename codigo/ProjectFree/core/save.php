<?php

require_once '../util/Util.php';

function save() {
	if (isset($_POST['submit']) && isset($_POST['entity'])) {
		$entityWhitelist = array(
			'projeto', 'usuario', 'artefato' ,'fase', 'atividade',
			'fale_conosco', 'mensagem', 'recurso', 'despesa', 'nota',
			'imagem', 'comentario', 'forma_de_contato', 'doacao'
		);
		$entity = $_POST['entity'];

		if (!in_array($entity, $entityWhitelist)) {
			redirect('/ProjectFree/application');
		}
		else{

		}
	}
	else{
		redirect('/ProjectFree/application');
	}

} save();