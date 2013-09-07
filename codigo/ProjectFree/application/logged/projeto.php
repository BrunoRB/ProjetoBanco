<?php

require_once 'main.php';

class Page_Projeto extends Main {

	public function __construct() {
		$this->setTitle('Projetos');
		parent::__construct();
	}

	public function loadBody() {
		parent::loadBody();
	}

	protected function exibir() {
		parent::exibir('projeto');
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
						<tr>
							<th>Nome</th>
							<th>Papel desempenhado</th>
						</tr>
					</thead>
					<tbody>
						<?php
						$this->retrieveList('projeto', array($this->getUserId()), array('nome', 'funcao'));
						?>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<a class="btn btn-primary btn-large" href="projeto.php?novo=true">Cadastrar novo projeto</a>
			</div>
		</div>
		<?php
	}

	protected function extraCallOnSucessForShow(){
		?>
		<div class="span5">
			<a class="btn btn-large btn-primary">Selecionar projeto</a>
		</div>
		<?php
	}

	private function selecionarProjeto() {
		global $userId;
		if (true) { // Check if user belongs to project
			$_SESSION['projectId'] = 1;
			$_SESSION['gerente'] = true;
			redirect('index.php');
		}
	}

	protected function cadastrar() {
		?>
		<div class="container">

			<form action="projeto.php?novo=true" method="post">
				Nome do projeto:
				<input id="nome" type="text" placeholder="Nome" name="nome" /> <br>
				Orçamento:
				<input id="login" type="text" placeholder="Login" name="orcamento" /> <br>
				Descrição:
				<textarea data-type="text-multi" name="descricao"></textarea> <br>
				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
				<input type="hidden" name="entity" value="projeto" >
				<input type="hidden" name="fields" value="idGerente,nome,orcamento,descricao">
				<input type="hidden" name="idGerente" value="<?php echo $this->getUserId();?>">
			</form>
		</div>
		<?php
	}


} new Page_Projeto();