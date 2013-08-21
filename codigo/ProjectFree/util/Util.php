<?php

/**
 * Redireciona página
 *
 * @param string $url Url para a qual usuário deve ser redirecionado
 */
function redirect($url) {
	header("Location: $url");
	session_write_close();
	ob_end_flush();
	die();
}

function printErrorMessage($message) {
	echo <<<MESSAGE
	<div class="alert alert-error">
  		<span><i class="icon-warning-sign"></i> $message</span>
	</div>
MESSAGE;

}

function printAlertMessage() {
	echo <<<MESSAGE

MESSAGE;
}

/**
 * Valida se campos foram preenchidos após o submit de o formulário POST
 *
 * @param array $fields campos a serem validados
 * @return boolean
 */
function checkMandatoryPostFields(array $fields) {
	$flag = true;
	$invalidFields = array();
	$validFields = array();
	foreach ($fields as $field) {
		if (!isset($_POST[$field]) || empty($_POST[$field])) {
			$invalidFields[] = $field;
			$flag = false;
		}
		else {
			$validFields[] = $field;
		}
	}
	return array('flag' => $flag, 'invalidFields' => $invalidFields, 'validFields' => $validFields);
}