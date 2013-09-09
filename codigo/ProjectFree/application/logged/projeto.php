<?php

require_once 'main.php';

class Page_Projeto extends Main {

	public function __construct() {
		$this->setTitle('Projetos');
		parent::__construct();
	}
	
	protected function loadBody() {
		parent::loadBody();
		if (isset($_GET['selecionar'])) {
			$this->guardarProjetoNaSessao();
		}
	}

	protected function novo(array $campos = array()) {
		$gerente = 'nome,orcamento,descricao';
		$membro = 'nome,orcamento,descricao';
		parent::novo(array('gerente' => $gerente, 'membro' => $membro));
	}
	
	protected function funcaoExtraParaExibir() {
		?>
		<div class="span4">
			<a href="projeto.php?selecionar=<?php echo $_GET['exibir'];?>" class="btn btn-large btn-primary">Selecionar este projeto</a>
		</div>
		<?php
	}
	
	private function guardarProjetoNaSessao() {
		$idProjeto = $_GET['selecionar'];
		if (isset($idProjeto)) {
			$_SESSION['projectId'] = $idProjeto;
			redirect('index.php');
		}
		else {
			unset($_SESSION['projectId']);
		}
	}

} new Page_Projeto();