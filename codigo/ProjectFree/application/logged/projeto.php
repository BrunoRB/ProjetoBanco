<?php

require_once 'main.php';

class Projeto extends Main {

	public function __construct() {
		$this->setTitle('Projetos');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->cadastrarProjeto();
		}
		else if (isset($_GET['selecionar']) && is_numeric($_GET['selecionar'])) {
			$this->selecionarProjeto();
		}
		else if (isset($_GET['id']) && is_numeric($_GET['id'])) { //TODO check if id == number
			$this->show();
		}
		else {
			$this->listarProjetos();
		}
	}

	private function listarProjetos() {
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
						<tr>
							<td><a href="projeto.php?id=1">ProjectFree - Gerenciamento de projetos</a></td>
							<td>Gerente do projeto</td>
						</tr>
						<tr>
							<td><a href="projeto.php?id=1">Long Night - Sistema para gerenciamento de festas</a></td>
							<td>Desenvolvedor back-end</td>
						</tr>
						<tr>
							<td><a href="projeto.php?id=1">Sistema tal</a></td>
							<td>Desenvolvedor front-end</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<form action="<?php echo SAVE_FILE;?>" method="post">
					<a class="btn btn-primary btn-large" href="projeto.php?novo=true">Cadastrar novo projeto</a>
				</form>
			</div>
		</div>
		<?php
	}

	private function show() {
		?>
			Projeto: ProjectFree - Gerenciamento de projetos

			<br>

			Gerente: Bruno

			<br>

			Meu papel no projeto: Gerente

			<br>

			Número de membros do projeto: 1

			<br>

			Orçamento: R$-10.000

			<br>

			Data de cadastro do projeto: 01/04/2013

			<br>

			Descrição:  Ne vero ex hac nostra decem dierum subtractione, alicui,
			quod ad annuas vel menstruas praestationes pertinet, praeiudicium fiat,
			partes iudicum erunt in controversis, quae super hoc exortae fuerint,
			dictae subtractionis rationem habere, addendo alios X dies in fine cuiuslibet praestationis.

			<br>

			<a type="submit" class="btn btn-primary btn-large" href="projeto.php?selecionar=1">Selecionar projeto</a>

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

	private function cadastrarProjeto() {
		?>
		<div class="container">

			<form action="<?php echo SAVE_FILE;?>" method="post">
				Nome do projeto:
				<input id="nome" type="text" placeholder="Nome" name="nome" /> <br>
				Orçamento:
				<input id="login" type="text" placeholder="Login" name="login" /> <br>
				Descrição:
				<textarea data-type="text-multi" name="descricao"></textarea> <br>
				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}


} new Projeto();