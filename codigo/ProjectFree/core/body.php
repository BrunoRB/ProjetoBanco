<?php

require_once $_SERVER['DOCUMENT_ROOT'] . '/ProjetoBanco/codigo/ProjectFree/util/Constants.php';

require_once ROOT_FOLDER . '/util/Util.php';

require_once ROOT_FOLDER . '/util/PostgresConnect.php';

require_once ROOT_FOLDER . '/templates/header.php';
require_once ROOT_FOLDER . '/templates/footer.php';

require_once ROOT_FOLDER . '/entitys/Usuario.php';
require_once ROOT_FOLDER . '/entitys/Projeto.php';
require_once ROOT_FOLDER . '/entitys/Artefato.php';
require_once ROOT_FOLDER . '/entitys/Atividade.php';
require_once ROOT_FOLDER . '/entitys/Fase.php';

class Body {
	private $header;
	private $title;
	private $extraHeader;

	public function __construct() {
		$this->header = new Header();
		$this->header->setTitle($this->title);
		$this->header->setExtraHeader($this->extraHeader);
		$this->init();
		//$this->setHeaderType();
	}

	protected function init() {
		$this->header->loadHead();
		$this->loadBody();
		Footer::loadFooter();
	}

	protected function loadBody() {
		if (isset($_POST['salvar'])) {
			$this->salvar();
		}
		if (isset($_GET['exibir'])) {
			$this->exibir();
		}
		else if (isset($_GET['novo']) || isset($_GET['alterar'])) {
			$this->novo();
		}
		else if (isset($_POST['deletar'])) {
			$this->deletar();
		}
		else {
			$this->listar();
		}
	}

	protected function novo(array $campos = array()) {
		echo <<<HEAD
<div class="container">
	<form action="{$this->getEntity()}.php" method="post">
HEAD;
		$role = ucfirst($this->getRole());
		$campos = $campos[strtolower('gerente')];
		if (isset($_GET['novo'])) {
			$this->novoCadastrar($campos);
		}
		else {
			$this->novoAlterar(strtolower($role));
		}

		echo <<<FOOT
		<button name="salvar" class="btn btn-large btn-primary">Salvar</button>
	</form>
</div>
FOOT;
	}
	
	private function novoCadastrar($campos) {
		$pgConnect = new PostgresConnection();
		$query = 'SELECT ' . $campos . ' FROM ' . $this->getEntity() . ' LIMIT 0';
		$result = pg_query($pgConnect->getConnection(), $query);
		$colNames = $pgConnect->getNames($result);
		$colTypes = $pgConnect->getTypes($result);
		$i = 0;
		$campos = split(',', $campos);
		foreach ($colTypes as $type) {
			$name = $colNames[$i];
			echo ucfirst($campos[$i++]) . ': ';
			if ($type == 'varchar' || $type == 'numeric') {
				echo '<input type="text" placeholder="' . $name . '" name="' . $name . '" /><br>';
			}
			else if ($type == 'text') {
				echo '<textarea data-type="text-multi" name="' . $name . '" ></textarea> <br>';
			}
			else if ($type == 'date') {
				echo '<input type="text" data-type="timestamp" placeholder="dd/mm/aaaa" name="dataInicio" /> <br>';
			}
			else if ($type == 'timestamp') {
				echo '<input type="text" data-type="timestamp" placeholder="dd/mm/aaaa" name="dataInicio" /> <br>';
			}
			else if (strpos($type, 'int') !== false) {
				echo '<input name="' . $name . '" data-type="text-number" value="' . $colValue . '" /><br>';
			}
		}
		$pgConnect->closeConnection();
	}
	
	private function novoAlterar($role) {
		$pgConnect = new PostgresConnection();
		if ($this->getEntity() == 'projeto') {
			$parameters = array($this->getUserId(), $_GET['alterar']);
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId(), $_GET['alterar']);
		}
		$functionName = $this->getEntity() . 'Exibir' . $role; // ex: usuarioCadastrar
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getArrayOfResultsFromSelect($retval);
		$types = $pgConnect->getTypes($retval);
		$i = 0;
		foreach (current($result) as $colName => $colValue) {
			$type = $types[$i++];
			echo ucfirst($colName) . ': ';
			if ($type == 'varchar' || $type == 'numeric') {
				echo '<input type="text" placeholder="' . $colName . '" name="' . $colName . '" value="' . $colValue . '" /><br>';
			}
			else if ($type == 'text') {
				echo '<textarea data-type="text-multi" name="' . $colName . '" >' . $colValue . '</textarea> <br>';
			}
			else if ($type == 'date') {
				if (isset($colValue)) {
					$date = strtotime($colValue);
					$colValue = date('d/m/Y', $date);
				}
				echo '<input type="text" data-type="date" placeholder="dd/mm/aaaa" name="' . $colName . '" " value="' . $colValue . '" /> <br>';
			}
			else if ($type == 'timestamp') {
				if (isset($colValue)) {
					$date = strtotime($colValue);
					$colValue = date('d/m/Y', $date);
				}
				echo '<input type="text" data-type="timestamp" placeholder="dd/mm/aaaa" name="' . $colName . '" " value="' . $colValue . '" /> <br>';
			}
			else if (strpos($type, 'int') !== false) {
				echo '<input data-type="text-number" placeholder="' . $colName . '" name="' . $colName . '" value="' . $colValue . '" /><br>';
			}
		}
		echo '<input type="hidden" name="alterar" value="' . $_GET['alterar'] . '" />';
		$pgConnect->closeConnection();
	}

	protected function exibir() {
		$parameters = ($this->getEntity() == 'projeto') ? 
			array($this->getUserId(), $_GET['exibir']) : array($this->getUserId(), $this->getProjectId(), $_GET['exibir']);
		$role = ucfirst($this->getRole());
		
		$pgConnect = new PostgresConnection();
		$functionName = $this->getEntity() . 'Exibir' . $role; // ex: usuarioCadastrar
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getArrayOfResultsFromSelect($retval);

		if (!empty($result)) {
			echo '<div class="row-fluid show"><div class="span7">';
			foreach ($result as $row) {
				foreach ($row as $columnName => $columnValue) {
		?>
		<div>
			<strong><?php echo ucfirst($columnName) . ': ';?></strong> <?php echo isset($columnValue) ? $columnValue : 'N/A';?>
		</div>
		<?php
				}
			}
			?>
			<form method="post" action="<?php echo $this->getEntity();?>.php">
				<a class="btn btn-large btn-info" href="<?php echo $this->getEntity();?>.php?alterar=<?php echo $_GET['exibir'];?>">Alterar</a>
				<button class="btn btn-large btn-danger" name="deletar" value="<?php echo $_GET['exibir'];?>">Excluir</button>
			</form>
			<?php
			echo '</div>';
			$this->funcaoExtraParaExibir();
			echo '</div>';
		}
		else {
			printErrorMessage('Erro ao exibir ' . $entity);
		}
		$pgConnect->closeConnection();
	}
	
	protected function funcaoExtraParaExibir() {}

	protected function deletar() {
		$pgConnect = new PostgresConnection();
		$functionName = $this->getEntity() . 'Excluir'; // ex: usuarioCadastrar
		if ($this->getEntity() == 'projeto') {
			$parameters = array($this->getUserId(), $_POST['deletar']);
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId(), $_POST['deletar']);
		}
		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getArrayOfResultsFromSelect($retval);
		$pgConnect->closeConnection();
		
		if (current($result)[strtolower($functionName)] != 0) {
			printSuccessMessage(ucfirst($this->getEntity()) . ' deletado com sucesso');
		}
		else {
			printErrorMessage(ucfirst($this->getEntity()) . ' não pode ser removido');
		}
		$this->listar();
	}

	protected function listar() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="<?php echo $this->getEntity();?>">
				<table class="table table-hover-mod">
					<caption>
						<a data-toggle="collapse" data-target="<?php echo '#' . $this->getEntity();?>">
							<h2><?php echo ucfirst($this->getEntity());?></h2>
						</a>
					</caption>
					<thead>
						<?php
						echo '<tr>';
						foreach ($this->getListarNames() as $colName) {
							echo '<td>' . ucfirst($colName) . '</td>';
						}
						echo '</tr>';
						?>
					</thead>
					<tbody>
						<?php
						foreach($this->getListarData() as $row) {
							echo '<tr class="list">';
								foreach ($row as $colVal) {
									$siglaId = 'id_' . $this->getEntity();
									echo '<td>';
									echo '<a href="' . $this->getEntity() . '.php?exibir=' . $row[$siglaId] . '">' . $colVal . '</a>';									
									echo '</td>';
								}
							echo '</tr>';
						}
						?>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<a class="btn btn-primary btn-large" href="<?php echo $this->getEntity();?>.php?novo=true">Cadastrar
					novo <?php echo $this->getEntity();?></a>
						<?php $this->extraFunctionOnListar();?>
			</div>
		
		</div>
		<?php
	}
	
	protected function extraFunctionOnListar() {}

	protected function getListarData() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$functionName = $entity . 'Listar';
		if ($entity == 'projeto') {
			$parameters = array($this->getUserId());
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId());
		}
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);
		$pgConnect->closeConnection();
		return $result;
	}
	
	protected function getListarNames() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$functionName = $entity . 'Listar';
		if ($entity == 'projeto') {
			$parameters = array($this->getUserId());
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId());
		}
		
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getNames($retval);
		$pgConnect->closeConnection();
		return $result;
	}

	protected function salvar() {
		$entity = $this->getEntity();
		$parameters = array();
		
		foreach ($_POST as $fieldName => $fieldValue) {
			if ($fieldName == 'salvar' || $fieldName == 'alterar') {
				break;
			}
			else if ($fieldValue == '') {
				$fieldValue = null;
			}
			$parameters[] = $fieldValue;
		}
		
		if ($this->getEntity() == 'cadastro') {

		}
		else if ($entity == 'projeto'){
			if (!isset($_POST['alterar'])) {
				$parameters = array_merge(array($this->getUserId()), $parameters);
			}
			else {
				$parameters = array_merge(array($this->getUserId(), $_POST['alterar']), $parameters);
			}
		}
		else {
			if (!isset($_POST['alterar'])) {
				$parameters = array_merge(array($this->getUserId(), $this->getProjectId()), $parameters);
			}
			else {
				$parameters = array_merge(array($this->getUserId(), $this->getProjectId(), $_POST['alterar']), $parameters);
			}			
		}

		if ($this->getEntity() == 'cadastro') {
			$functionName = 'usuarioCadastrar';
		}
		else if (!isset($_POST['alterar'])) {
			$functionName = $this->getEntity() . 'Cadastrar';
		}
		else {			
			$functionName = $this->getEntity() . 'Atualizar';
		}
	
		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);
		
		if ($result != 0)
			printSuccessMessage('Sucesso ao salvar ' . $entity);
		else
			printErrorMessage('Erro ao tentar salvar ' . $entity);
	}
	
	protected function setTitle($title) {
		$this->title = $title;
	}

	protected function setExtraHeader($extraHeader) {
		$this->extraHeader = $extraHeader;
	}

	public function getUserId() {
		global $userId;
		return isset($userId) ? $userId : null;
	}

	public function getProjectId() {
		global $projectId;
		return isset($projectId) ? $projectId : null;
	}

	protected function getEntity() {
		return strtolower(str_replace('Page_', '', get_called_class()));
	}

	protected function getRole() {
		$pgConnect = new PostgresConnection();
		$parameters = null;
		if ($this->getEntity() == 'projeto') {
			if (isset($_GET['exibir'])) {
				$parameters = array($this->getUserId(), $_GET['exibir']);
			}
			else if (isset($_GET['alterar'])) {
				$parameters = array($this->getUserId(), $_GET['alterar']);
			}
			else {
				return '';
			}
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId());
		}
		
		$functionName = 'getRole';
		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);
		$role = current($result);
		$role = $role['getrole'];

		$pgConnect->closeConnection();


		return $role;
	}
}
