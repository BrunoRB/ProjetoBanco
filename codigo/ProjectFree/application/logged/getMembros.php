<?php

require_once 'main.php';


$pgConnect = new PostgresConnection();

$functionName = 'buscarUsuarios';
$parameters = array('ag');
$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
$results = $pgConnect->getArrayOfResultsFromSelect($retval);

var_dump($results);

foreach ($results as $user) {
	echo '"' . $user['nome'] . '(' . $user['email'] . ')' . '"';
}

$pgConnect->closeConnection();