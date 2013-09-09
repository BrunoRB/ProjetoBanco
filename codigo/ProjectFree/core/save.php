<?php

require_once '../util/Constants.php';
require_once ROOT_FOLDER . '/util/Util.php';
require_once ROOT_FOLDER . '/entitys/Usuario.php';
require_once ROOT_FOLDER . '/util/PostgresConnect.php';

class Save {

	public function __construct() {
		if (isset($_POST['submit'])) {
			$this->validateSave();
		}
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

			if ($id > 0) {

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

} new Save();