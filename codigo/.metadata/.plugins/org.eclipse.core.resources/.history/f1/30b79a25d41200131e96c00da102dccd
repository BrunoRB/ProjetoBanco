<?php

session_start();

$userId = isset($_SESSION['userId']) ? $_SESSION['userId'] : false;
$projectId = isset($_SESSION['projectId']) ? $_SESSION['projectId'] : false;
$gerente = isset($_SESSION['gerente']) && $_SESSION['gerente'] == true ? true : false;

class Header{
	private $title;
	private $extraHeader = array();

	public function loadHead() {
		global $userId;
		global $projectId;
		global $gerente;

		$path = ($userId === false) ? '/ProjectFree/application/' : '/ProjectFree/application/logged/';
		?>
<!DOCTYPE html>

<html lang="pt-BR">
	<head>
		<meta charset='utf-8' />
		<title><?php echo isset($this->title) ? $this->title . ' | ' : '';?>Project Free</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/bootstrap-responsive.css" />
		<link rel="stylesheet" href="/ProjectFree/resources/fonts/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/main.css" />
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/smoothness/jquery-ui-1.10.3.custom.css" />
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/cleditor/jquery.cleditor.css" />

		<script type="text/javascript" src="/ProjectFree/resources/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="/ProjectFree/resources/js/jquery-ui-1.10.3.custom.js"></script>
		<script type="text/javascript" src="/ProjectFree/resources/js/bootstrap.js"></script>
		<script type="text/javascript" src="/ProjectFree/resources/cleditor/jquery.cleditor.min.js"></script>
		<script type="text/javascript" src="/ProjectFree/resources/js/projectfree.js"></script>
		<?php
		if (isset($this->extraHeader)) {
			foreach ($this->extraHeader as $extra) {
				echo $extra;
			}
		}
		?>
	</head>
	<body>
		<header>
			<div class="pagination-centered">
				<nav class="navbar-inverse">
					<div class="navbar navbar-fixed-top navbar-inner ">
						<a class="brand" href="<?php echo $path . 'index.php'; ?>"><i class="icon-home"></i></a>
						<?php
							if ($userId === false) {
								$this->anonymous();
							}
							else if ($projectId === false) {
								$this->loggedHeader();
							}
							else if($gerente === false) {
								$this->loggedWithProjectHeader();
							}
							else {
								$this->loggedManagerHeader();
							}
						?>
					</div>
				</nav>
				<h1>ProjectFree</h1>
			</div>
		</header>
		<?php
	}

	private function anonymous() {
		?>
		<div>
			<ul class="nav">
				<li><a class="brand" href="cadastro.php">Cadastrar-se</a></li>
				<li><a class="brand" href="login.php">Logar</a></li>
			</ul>
		</div>
		<div class="pull-right">
			<ul class="nav">
				<li><a href="/ProjectFree/application/cadastro.php">Cadastro</a></li>
				<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
				<li><a href="/ProjectFree/application/sobre.php">Sobre</a></li>
				<li><a href="/ProjectFree/application/doe.php">Doe !</a></li>
			</ul>
		</div>
		<?php
	}

	private function loggedHeader() {
		$this->loggedRightMenu();
	}

	private function loggedWithProjectHeader() {
		?>
		<ul class="nav">
			<li class="brand">Nome do Projeto
			<li><a href="/ProjectFree/application/logged/atividade.php">Atividades</a></li>
			<li><a href="/ProjectFree/application/logged/membro.php">Membros</a></li>
		</ul>
		<?php
		$this->loggedRightMenu();
	}

	private function loggedManagerHeader() {
		?>
		<ul class="nav">
			<li class="brand">Nome do Projeto
			<li><a href="/ProjectFree/application/logged/cronograma.php">Cronograma</a></li>
			<li><a href="/ProjectFree/application/logged/fase.php">Fases</a></li>
			<li><a href="/ProjectFree/application/logged/atividade.php">Atividades</a></li>
			<li><a href="/ProjectFree/application/logged/membro.php">Membros</a></li>
			<li><a href="/ProjectFree/application/logged/artefato.php">Artefatos</a></li>
		</ul>
		<?php
		$this->loggedRightMenu();
	}

	private function loggedRightMenu() {
		?>
		<div class="pull-right">
			<ul class="nav">
				<li><a href="/ProjectFree/application/logged/projeto.php">Projetos</a></li>
				<li><a href="/ProjectFree/application/mensagem.php">Mensagens</a></li>
				<li><a href="/ProjectFree/application/logged/nota.php">Notas</a></li>
				<li><a href="/ProjectFree/application/logged/">Convites</a></li>
				<li><a href="/ProjectFree/application/logged/">Perfil</a></li>
				<li><a href="/ProjectFree/application/login.php?logout=true">Logout</a></li>
			</ul>
		</div>
		<?php
	}

	public function setTitle($title) {
		$this->title = $title;
	}

	public function setExtraHeader($extraHeader) {
		$this->extraHeader[] = $extraHeader;
	}
}