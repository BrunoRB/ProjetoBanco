<?php

require_once 'main.php';

class Page_Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}

	protected function novo(array $campos = array()) {
		$gerente = 'inicio_atividade,limite_atividade,nome_atividade,descricao_atividade,fk_predecessora,fk_fase';
		parent::novo(array('gerente' => $gerente));
	}

		
	protected function getListarNames() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$functionName = 'atividadeIncompletaListarGerente';
		$parameters = array($this->getUserId(), $this->getProjectId());
		
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getNames($retval);
		$pgConnect->closeConnection();
		return $result;
	}
} new Page_Atividade();