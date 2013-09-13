<?php

session_start();

$userId = isset($_SESSION['userId']) ? $_SESSION['userId'] : false;
$projectId = isset($_SESSION['projectId']) ? $_SESSION['projectId'] : false;
$gerente = strtolower(getRole()) == 'gerente' ? true : false;

class Header{
	private $title;
	private $extraHeader = array();

	public function loadHead() {
		global $userId;
		global $projectId;
		global $gerente;

		$path = ($userId === false) ? '/ProjetoBanco/codigo/ProjectFree/application/' : '/ProjetoBanco/codigo/ProjectFree/application/logged/';
		?>
<!DOCTYPE html>

<html lang="pt-BR">
	<head>
		<meta charset='utf-8' />
		<title><?php echo isset($this->title) ? $this->title . ' | ' : '';?>Project Free</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/ProjetoBanco/codigo/ProjectFree/resources/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="/ProjetoBanco/codigo/ProjectFree/resources/css/bootstrap-responsive.css" />
		<link rel="stylesheet" href="/ProjetoBanco/codigo/ProjectFree/resources/fonts/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/ProjetoBanco/codigo/ProjectFree/resources/css/main.css" />
		<link rel="stylesheet" type="text/css" href="/ProjetoBanco/codigo/ProjectFree/resources/css/smoothness/jquery-ui-1.10.3.custom.css" />
		<link rel="stylesheet" type="text/css" href="/ProjetoBanco/codigo/ProjectFree/resources/cleditor/jquery.cleditor.css" />

		<script type="text/javascript" src="/ProjetoBanco/codigo/ProjectFree/resources/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="/ProjetoBanco/codigo/ProjectFree/resources/js/jquery-ui-1.10.3.custom.js"></script>
		<script type="text/javascript" src="/ProjetoBanco/codigo/ProjectFree/resources/js/bootstrap.js"></script>
		<script type="text/javascript" src="/ProjetoBanco/codigo/ProjectFree/resources/cleditor/jquery.cleditor.min.js"></script>
		<script type="text/javascript" src="/ProjetoBanco/codigo/ProjectFree/resources/js/projectfree.js"></script>
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
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/sobre.php">Sobre</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/doe.php">Doe !</a></li>
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
			<li class="brand"><?php echo getNomeProjeto();?>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/atividade.php">Atividades</a></li>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/membro.php">Membros</a></li>
		</ul>
		<?php
		$this->loggedRightMenu();
	}

	private function loggedManagerHeader() {
		?>
		<ul class="nav">
			<li class="brand"><?php echo getNomeProjeto();?>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/cronograma.php">Cronograma</a></li>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/fase.php">Fases</a></li>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/atividade.php">Atividades</a></li>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/membro.php">Membros</a></li>
			<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/artefato.php">Artefatos</a></li>
		</ul>
		<?php
		$this->loggedRightMenu();
	}

	private function loggedRightMenu() {
		?>
		<div class="pull-right">
			<ul class="nav">
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/projeto.php">Projetos</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/mensagem.php">Mensagens</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/nota.php">Notas</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/convite.php">Convites</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/logged/perfil.php">Perfil</a></li>
				<li><a href="/ProjetoBanco/codigo/ProjectFree/application/login.php?logout=true">Logout</a></li>
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

function getRole() {
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

function getNomeProjeto() {
	require_once $_SERVER['DOCUMENT_ROOT'] . '/ProjetoBanco/codigo/ProjectFree/util/PostgresConnect.php';
	$pgConnect = new PostgresConnection();

	global $projectId;
	global $userId;
	global $gerente;
	$parameters = array($userId, $projectId);
	$functionName = $gerente ? 'projetoExibirGerente' : 'projetoExibirMembro';
	$prepare = $pgConnect->prepareFunctionStatementSelect($functionName, count($parameters));
	$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
	$result = $pgConnect->getArrayOfResultsFromSelect($retval);

	$pgConnect->closeConnection();

	return current($result)['nome'];
}