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

function printWarningMessage($message) {
	echo <<<MESSAGE
	<div class="alert alert-warning">
  		<span><i class="icon-warning-sign"></i> $message</span>
	</div>
MESSAGE;
}

function printSuccessMessage($message) {
	echo <<<MESSAGE
	<div class="alert alert-success">
  		<span><i class="icon-success-sign"></i> $message</span>
	</div>
MESSAGE;
}

function printAlertMessage() {
	echo <<<MESSAGE

MESSAGE;
}

function refreshPage() {
	echo '<script type="text/javascript">location.reload();</script>';
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
	$i = 0;
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