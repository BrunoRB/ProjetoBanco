<?php

require_once 'main.php';

class Page_Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}
	
	protected function loadBody() {
		if (isset($_POST['finalizar'])) {
			$this->finalizarAtividade($_POST['finalizar']);
		}
		else {
			parent::loadBody();
		}
	}

	protected function novo(array $campos = array()) {
		$gerente = 'inicio_atividade,limite_atividade,nome_atividade,descricao_atividade,fk_predecessora,fk_fase';
		parent::novo(array('gerente' => $gerente));
	}
	
	protected function listar() {
		$this->listarCaption = 'Atividade incompletas';
		parent::listar();
		echo '<br>';
		$this->renderCadastrar = false;
		$this->listarCaption = 'Atividade completas';
		$this->listarCompletas();
	}
	
	protected function listarCompletas() {
		parent::listar();
	}
	
	// finalizar atividade
	protected function funcaoExtraParaExibir() {
		
		?>
		<form method="post" action="atividade.php">
			<button class="btn btn-large btn-primary" name="finalizar" value="<?php echo $_GET['exibir'];?>">Finalizar esta atividade</button>
		</form>
		<?php 
	}
	
	protected function finalizarAtividade($idAtividade) {
		$pgConnect = new PostgresConnection();
		$params = array($this->getUserId(), $this->getProjectId(), $idAtividade);
		$retval = $pgConnect->executeQueryWithParams('SELECT atividadeFinalizar($1, $2, $3)', $params);
		$result = $pgConnect->getResult($retval);
		$finalizada = current($result)['atividadefinalizar'];
		
		
		if (isset($finalizada) && $finalizada == '1')
			printSuccessMessage('Atividade finalizada com sucesso');
		else
			printErrorMessage('Erro ao tentar finalizar atividade');
		
		$this->listar();
	}
	
	protected function getListarNames() {
		$callers = debug_backtrace();
		if ($callers[2]['function'] == 'listarCompletas') {
			$functionName = 'atividadeCompletaListarGerente';
		}
		else {
			$functionName = 'atividadeIncompletaListarGerente';
		}
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		
		$parameters = array($this->getUserId(), $this->getProjectId());
		
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getNames($retval);
		$pgConnect->closeConnection();
		return $result;
	}
	
	protected function getListarData() {
		$callers = debug_backtrace();
		if ($callers[2]['function'] == 'listarCompletas') {
			$functionName = 'atividadeCompletaListarGerente';
		}
		else {
			$functionName = 'atividadeIncompletaListarGerente';
		}
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
	
		$parameters = array($this->getUserId(), $this->getProjectId());
		
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);
		$pgConnect->closeConnection();
		return $result;
	}
	
} new Page_Atividade();