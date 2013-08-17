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