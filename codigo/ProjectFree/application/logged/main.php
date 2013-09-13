<?php

require_once $_SERVER['DOCUMENT_ROOT'] . '/ProjetoBanco/codigo/ProjectFree/core/body.php';

class Main extends Body {

	public function __construct() {
		$this->isLogado();
		$this->setExtraHeader('<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/logged.css" />');
		parent::__construct();
	}
	
	protected function isLogado() {
		$url = $_SERVER['REQUEST_URI'];
		if (strpos($_SERVER['REQUEST_URI'], '/logged') != false) {
			$userId = $this->getUserId();
			if (isset($userId)) {
				$pgConnect = new PostgresConnection();
				$retval = $pgConnect->executeQueryWithParams('SELECT isLogado($1)', array($userId));
				$result = $pgConnect->getResult($retval);
				$isLogado = current($result)['islogado'];
				if ($isLogado != 't') {
					redirect('/ProjetoBanco/codigo/ProjectFree/application/login.php?logout=true');
				}
			}
			else {
				redirect('/ProjetoBanco/codigo/ProjectFree/application/login.php?logout=true');
			}
		}
	}
}