<?php

require_once $_SERVER['DOCUMENT_ROOT'] . 'ProjectFree/util/Constants.php';

require_once ROOT_FOLDER . '/util/Util.php';

require_once ROOT_FOLDER . '/util/PostgresConnect.php';

require_once ROOT_FOLDER . '/templates/header.php';
require_once ROOT_FOLDER . '/templates/footer.php';

require_once ROOT_FOLDER . '/entitys/Usuario.php';
require_once ROOT_FOLDER . '/entitys/Projeto.php';

class Body {
	private $header;
	private $title;
	private $extraHeader;

	public function __construct() {
		$this->header = new Header();
		$this->header->setTitle($this->title);
		$this->header->setExtraHeader($this->extraHeader);
		$this->init();
		if (isset($_POST['submit'])) {
			$this->validateSave();
		}
	}

	protected function init() {
		$this->header->loadHead();
		$this->loadBody();
		Footer::loadFooter();
	}

	protected function loadBody(){
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->cadastrar();
		}
		else if (isset($_GET['exibir'])) {
			$this->exibir();
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
			redirect('/ProjectFree/application');
		}
	}

	protected function save() {
		$fields = str_replace(' ', '', split(',', $_POST['fields']));
		$entity = ucfirst($_POST['entity']);

		$retval = checkMandatoryPostFields($fields);

		if ($retval['flag']) {
			$pgConnect = new PostgresConnection();

			$functionName = lcfirst($entity) . 'Cadastrar'; // ex: usuarioCadastrar


			$parameters = array();
			$obj = new $entity();
			foreach ($fields as $field) {
				$obj->{"set$field"}($_POST[$field]);
				$parameters[] = $obj->{"get$field"}();
			}

			$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

			$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);

			$result = $pgConnect->getResult($retval);

			$id = current(current($result));

			if (isset($id) && $id > 0) {
				printSuccessMessage($pgConnect->getNoticeString());
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

	protected function retrieveList($objectName, array $parameters, array $fields) {
		$pgConnect = new PostgresConnection();

		$functionName = $objectName . 'Listar'; // ex: usuarioCadastrar

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

		$retval = $pgConnect->executeQueryWithParams("SELECT * FROM $functionName($1)", $parameters);

		$result = $pgConnect->getResult($retval);

		if ($result !== false) {
			foreach ($result as $projeto) {
				?>
				<tr>
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

	protected function cadastrar() {}

	protected function listar() {}

	protected function exibir($entity) {
		$pgConnect = new PostgresConnection();

		$functionName = lcfirst($entity) . 'Exibir'; // ex: usuarioCadastrar

		$parameters = array();
		$obj = new $entity();
		foreach ($fields as $field) {
			$obj->{"set$field"}($_POST[$field]);
			$parameters[] = $obj->{"get$field"}();
		}

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);

		$result = $pgConnect->getResult($retval);

		$id = current(current($result));

		if (isset($id) && $id > 0) {
			printSuccessMessage($pgConnect->getNoticeString());
		}
		else {
			printErrorMessage($pgConnect->getErrorString());
		}

		$pgConnect->closeConnection();
	}
}
