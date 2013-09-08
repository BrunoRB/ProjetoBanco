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
		$this->setHeaderType();
	}

	protected function init() {
		$this->header->loadHead();
		$this->loadBody();
		Footer::loadFooter();
	}

	protected function setHeaderType() {
		$url = $_SERVER['REQUEST_URI'];
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		if (!$this->checkLogin()) {
			if (strpos($url, '/logged/') !== false) {
				$this->storeloginOnSession(false);
				redirect('/ProjetoBanco/codigo/ProjectFree/application/index.php');
			}
		}
		else if (strpos($url, '/logged/') !== false) {
			$role = $this->getRole();
			session_start();
			$_SERVER['gerente'] = (strtolower($role) == 'gerente') ? true: false;
		}
	}

	protected function loadBody(){
		if (isset($_POST['submit'])) {
			$this->validateSave();
		}
		else if (isset($_GET['novo']) || isset($_GET['alterar'])) {
			$this->cadastrar();
		}
		else if (isset($_GET['exibir'])) {
			$this->exibir();
		}
		else if (isset($_POST['delete'])) {
			$this->delete();
		}
		else {
			$this->listar();
		}
	}


	protected function setTitle($title) {
		$this->title = $title;
	}

	protected function setExtraHeader($extraHeader) {
		$this->extraHeader = $extraHeader;
	}

	protected function validateSave() {
		$entityWhitelist = array(
			'projeto', 'usuario', 'artefato' ,'fase', 'atividade',
			'fale_conosco', 'mensagem', 'recurso', 'despesa', 'nota',
			'imagem', 'comentario', 'forma_de_contato', 'doacao'
		);
		if (isset($_POST['submit']) && isset($_POST['entity'])
			&& isset($_POST['fields']) && in_array($_POST['entity'], $entityWhitelist)
		) {
			$this->save();
		}
		else{
			redirect('/ProjetoBanco/codigo/ProjectFree/application/logged/');
		}
	}

	protected function save() {
		$fields = str_replace(' ', '', split(',', $_POST['fields']));
		$entity = ucfirst($_POST['entity']);
		//$retval = checkMandatoryPostFields($fields);
		$retval['flag'] = true;

		if ($retval['flag']) {
			$pgConnect = new PostgresConnection();
			global $userId;
			global $projectId;

			$functionName = null;
			if (isset($_POST['alterar'])) {
				$functionName =  lcfirst($entity) . 'Atualizar';
				if ($entity != 'projeto')
					$parameters = array($userId, $projectId, $_GET['alterar']);
				else
					$parameters = array($userId, $_GET['alterar']);
			}
			else {
				$functionName = lcfirst($entity) . 'Cadastrar'; // ex: usuarioCadastrar
				if ($entity != 'projeto')
					$parameters = array($userId, $projectId);
				else
					$parameters = array($userId);
			}

			$obj = new $entity();
			foreach ($fields as $field) {
				if ($field == '') break;
				$value = $_POST[$field] != '' ? $_POST[$field] : null;
				$obj->{"set$field"}($value);
				$parameters[] = $obj->{"get$field"}();
			}

			$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

			$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);

			$result = $pgConnect->getResult($retval);


			$id = current(current($result));

			if (isset($id) && $id > 0) {
				printSuccessMessage($pgConnect->getNoticeString());
				$this->extraCallOnSucessOperation();
			}
			else {
				printErrorMessage($pgConnect->getErrorString());

			}

			$pgConnect->closeConnection();
		}
		else {
			printErrorMessage('É necessário preencher todos os campos obrigatórios !');
			?>
			<script type="text/javascript">
				<?php
				foreach ($retval['invalidFields'] as $invalidField) {
				?>
					$('input[name="<?php echo $invalidField;?>"]').css('background-color', 'black');
				<?php
				}
				if (!empty($retval['validFields'])) {
					foreach ($retval['validFields'] as $validField) {
					?>
						$('input[name="<?php echo $validField;?>"]').val('<?php echo $_POST[$validField];?>');
					<?php
					}
				}
				?>
			</script>
			<?php
		}
	}

	protected function show() {
	}

	protected function retrieveList(array $fields) {
		$objectName = strtolower(str_replace('Page_', '', get_called_class()));
		$pgConnect = new PostgresConnection();
		$functionName = $objectName . 'Listar'; // ex: usuarioCadastrar
		global $userId;
		$parameters = array($userId);
		if ($objectName != 'projeto') {
			global $projectId;
			$parameters[] = $projectId;
		}
		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeQueryWithParams("SELECT * FROM $functionName($1)", $parameters);
		$result = $pgConnect->getResult($retval);
		if ($result !== false) {
			foreach ($result as $projeto) {
				?>
				<tr class="list">
					<?php
					$id = $projeto["id_$objectName"];
					$link = $objectName . '.php?exibir=' . $id;
					foreach ($fields as $field) {
						echo "<td><a href='$link'>$projeto[$field]</a></td>";
					}
					?>
				</tr>
				<?php
			}
		}
		else {
			printWarningMessage("Nenhum {$objectName} encontrado");
		}

		$pgConnect->closeConnection();
	}

	public function getUserId() {
		global $userId;
		return isset($userId) ? $userId : null;
	}

	public function getProjectId() {
		global $projectId;
		return isset($projectId) ? $projectId : null;
	}

	protected function cadastrar() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		?>
		<div class="container">
			<form action="<?php echo $entity;?>.php" method="post">
		<?php
		global $projectId;
		global $userId;
		$parameters = ($entity == 'projeto') ? array($userId, $_GET['alterar']) : array($userId, $projectId, $_GET['alterar']);
		$role = ucfirst($this->getRole());
		$pgConnect = new PostgresConnection();
		$functionName = $entity . 'Exibir' . $role; // ex: usuarioCadastra

		if (isset($_GET['alterar'])) {
			$functionName = $entity . 'ExibirGerente'; // ex: usuarioCadastrar
			$parameters = $entity != 'projeto' ? array($userId, $projectId, $_GET['alterar']) : array($userId, $_GET['alterar']);
			$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
			$result = $pgConnect->executeFunctionStatement($functionName, $parameters);
			$data = current($pgConnect->getArrayOfResultsFromSelect($result));
		}
		else {
			if ($entity == 'projeto') $fields = 'nome,orcamento,descricao';
			else if ($entity == 'atividade') $fields = 'inicio_atividade,limite_atividade,nome_atividade,descricao_atividade,fk_predecessora,fk_fase';
			else if ($entity == 'artefato') $fields = 'nome,tipo,descricao';
			else if ($entity == 'fase') $fields = 'nome,descricao';
			$result = pg_query($pgConnect->getConnection(), 'SELECT ' . $fields . ' FROM ' . $entity . ' LIMIT 0');
			$data = null;
		}

		$types = $pgConnect->getTypes($result);
		$i = 0;
		if ($data !== null) {
			$columnNames = 'id_' . $entity . ',';
			echo '<input type="hidden" name="id_' . $entity .'" value="' . $_GET['alterar'] . '">';
			foreach ($data as $colName => $colValue) {
				$type = $types[$i];
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
				else if (strpos($type, 'int') !== false) {
					echo '<input data-type="number" placeholder="' . $colName . '" name="' . $colName . '" value="' . $colValue . '" /><br>';
				}
				$i++;
				$columnNames .= $colName . ',';
			}
		}
		else {
			$columnNames = '';
			$names = $pgConnect->getNames($result);
			foreach ($types as $type) {
				$name = $names[$i];
				echo ucfirst($name) . ': ';
				if ($type == 'varchar' || $type == 'numeric') {
					echo '<input type="text" placeholder="' . $name . '" name="' . $name . '" /><br>';
				}
				else if ($type == 'text') {
					echo '<textarea data-type="text-multi" name="' . $name . '" ></textarea> <br>';
				}
				else if ($type == 'date') {
					echo '<input type="text" data-type="timestamp" placeholder="dd/mm/aaaa" name="dataInicio" /> <br>';
				}
				else if (strpos($type, 'int') !== false) {
					echo '<input name="' . $name . '" data-type="text-number" type="text" value="' . $colValue . '" /><br>';
				}
				$i++;
				$columnNames .= $name . ',';
			}
		}
		$pgConnect->closeConnection();
		if (isset($_GET['alterar'])) echo '<input type="hidden" name="alterar" value="true"/>';
		?>
				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
				<input type="hidden" name="entity" value="<?php echo $entity;?>" >
				<input type="hidden" name="fields" value="<?php echo $columnNames;?>">
			</form>
		</div>
		<?php
	}

	protected function listar() {}

	protected function exibir() {
		global $projectId;
		global $userId;
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$parameters = ($entity == 'projeto') ? array($userId, $_GET['exibir']) : array($userId, $projectId, $_GET['exibir']);
		$role = ucfirst($this->getRole());
		$pgConnect = new PostgresConnection();

		$functionName = $entity . 'Exibir' . $role; // ex: usuarioCadastrar

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
			<form method="post" action="projeto.php">
				<a class="btn btn-large btn-info" href="projeto.php?alterar=<?php echo $_GET['exibir'];?>">Alterar</a>
				<button class="btn btn-large btn-danger" name="delete" value="<?php echo $_GET['exibir'];?>">Excluir</button>
			</form>
			<?php
			echo '</div>';
			$this->extraCallOnSucessForShow();
			echo '</div>';
		}
		else {
			printErrorMessage('Erro ao exibir ' . $entity);
		}
		$pgConnect->closeConnection();
	}

	protected function extraCallOnSucessForShow(){}

	/**
	 *	Sobrescreva caso necessite de uma operação extra após a finalização de alguma função CRUD
	 *
	 */
	protected function extraCallOnSucessOperation() {}

	protected function login() {
		if (empty($_POST['email']) || empty($_POST['senha'])) {
			$this->show();
			printErrorMessage('Erro, preencha os campos login e senha !');
		}
		else {
			$user = $this->createUser();
			$pgConnect = new PostgresConnection();
			$functionName = 'logar';
			$parameters = array($user->getEmail(), $user->getSenha());
			$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
			$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
			$result = $pgConnect->getResult($retval);

			$id = current(current($result));

			$pgConnect->closeConnection();

			if (isset($id) && $id > 0) {
				$this->storeloginOnSession($id);
				redirect('logged/index.php');
			}
			else {
				unset($_POST);
				$this->show();
				printErrorMessage('Erro, login e/ou senha inválidos !');
			}
		}
	}

	protected function createUser() {
		$user = new Usuario();
		$user->setEmail($_POST['email']);
		$user->setSenha($_POST['senha']);
		return $user;
	}

	protected function storeloginOnSession($id) {
		if ($id !== false) {
			$_SESSION['userId'] = $id;
			var_dump($_SESSION);
		}
		else {
			unset($_SESSION['userId']);
			unset($_SESSION['projectId']);
		}
	}

	private function checkLogin() {
		$pgConnect = new PostgresConnection();

		$functionName = 'isLogado';
		global $userId;
		$parameters = array($userId);

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);

		$result = $pgConnect->getResult($retval);

		$result = current(current($result));

		$pgConnect->closeConnection();
		return  $result;
	}

	protected function getRole() {
		$pgConnect = new PostgresConnection();
		global $projectId;
		global $userId;
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$parameters = null;
		if ($entity == 'projeto') {
			if (isset($_GET['exibir'])) {
				$parameters = array($userId, $_GET['exibir']);
			}
			else if (isset($_GET['alterar'])) {
				$parameters = array($userId, $_GET['alterar']);
			}
			else {
				return '';
			}
		}
		else {
			if (isset($_GET['exibir'])) {
				$parameters = array($userId, $projectId, $_GET['exibir']);
			}
			else if (isset($_GET['alterar'])) {
				$parameters = array($userId, $projectId, $_GET['alterar']);
			}
			else {
				return '';
			}
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

	protected function delete() {
		$entity = strtolower(str_replace('Page_', '', get_called_class()));
		$pgConnect = new PostgresConnection();
		$functionName = $entity . 'Excluir'; // ex: usuarioCadastrar
		global $userId;
		global $projectId;

		if ($entity == 'projeto')
			$parameters = array($userId, $_POST['delete']);
		else
			$parameters = array($userId, $projectId, $_POST['delete']);

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
		$result = $pgConnect->getArrayOfResultsFromSelect($retval);
		$pgConnect->closeConnection();

		$this->listar();
		if (current($result)[strtolower($functionName)] != 0) {
			printSuccessMessage('[SUCESSO]' . ucfirst($entity) . 'deletado com sucesso');
		}
		else {
			printErrorMessage('[ERRO]' . ucfirst($entity) . ' não pode ser removido');
		}

	}
}
