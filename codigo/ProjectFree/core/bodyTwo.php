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
		if (isset($_GET['exibir'])) {
			$this->exibir();
		}
		else if (isset($_GET['novo'])) {
			$this->novo();
		}
		else if (isset($_GET['exibir'])) {
			$this->exibir();
		}
		else if (isset($_POST['deletar'])) {
			$this->deletar();
		}
		else {
			$this->listar();
		}
	}

	protected function novo() {

	}

	protected function exibir() {

	}

	protected function deletar() {

	}

	protected function listar() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="projetos">
				<table class="table table-hover-mod">
					<caption>
						<a data-toggle="collapse" data-target="#projetos">Projetos ativos</a>
					</caption>
					<thead>
						<?php
						foreach($this->getListarData() as $data) {
							echo '<tr>';
							foreach ($data as $colName => $colVal) {
								echo '<td>' . $colName . '</td>';
							}
							echo '</tr>';
						}
						?>
					</thead>
					<tbody>
						<?php
						foreach($this->getListarData() as $row) {
							echo '<tr>';
								foreach ($row as $colVal) {
									echo '<td>' . $colVal . '</td>';
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
			</div>
		</div>
		<?php
	}

	private function getListarData() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$pgConnect = new PostgresConnection();
		$functionName = $entity . 'Listar' . $this->getRole();
		var_dump($functionName);
		exit();
		if ($entity == 'projeto') {
			$parameters = array($this->getUserId());
		}
		else {
			$parameters = array($this->getUserId(), $this->getProjectId());
		}
		$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);
		$pgConnect->closeConnection();
		return $result;
	}

	protected function salvar() {
		$entity = $this->getEntity();
		$parameters = array();
		foreach ($_POST as $fieldName => $fieldValue) {
			if ($fieldName == 'submit') {
				break;
			}
			$parameters[] = $fieldValue;
		}
		if ($entity == 'cadastro') {
			$entity = 'usuario';
		}
		$functionName = $entity . 'Cadastrar';

		$pgConnect = new PostgresConnection();
		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getResult($retval);

		if ($result != 0)
			printSuccessMessage('Sucesso ao cadastrar ' . $entity);
		else
			printErrorMessage('Erro ao tentar cadastrar ' . $entity);
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

	private function getEntity() {
		return strtolower(str_replace('Page_', '', get_called_class()));
	}

	protected function getRole() {
		$pgConnect = new PostgresConnection();
		global $projectId;
		global $userId;
		if (!isset($projectId) || $projectId === false || !isset($userId) || $userId === false) {
			return '';
		}
		$parameters = array($userId, $projectId);

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
