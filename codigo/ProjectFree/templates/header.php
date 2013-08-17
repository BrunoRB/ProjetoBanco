<?php

class Header{
	private static $title;
	private static $extraHeader;

	public static function loadHead() {
		?>
<!DOCTYPE html>

<html lang="pt-BR">
	<head>
		<meta charset='utf-8' />
		<title><?php echo isset(self::$title) ? self::$title . ' | ' : '';?>Project Free</title>

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
		if (isset(self::$extraHeader)) {
			foreach (self::$extraHeader as $extra) {
				echo $extra;
			}
		}
		?>

	</head>
	<body>
		<header>
			<?php
			if (false) {
					?>
				<div class="pagination-centered">
					<nav class="navbar-inverse">
						<div class="navbar navbar-fixed-top navbar-inner ">
							<a class="brand" href="<?php echo $urlApps;?>index.php"><i class="icon-home"></i></a>
							<ul class="nav pull-right">
								<li><a href="/ProjectFree/application/sobre.php">Sobre</a></li>
								<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
								<li><a href="/ProjectFree/application/cadastro.php">Cadastrar</a></li>
								<li><a href="/ProjectFree/application/login.php">Logar</a></li>
							</ul>
						</div>
					</nav>
					<h1>ProjectFree</h1>
				</div>
				<?php
			}
			else if (false) {
				?>
				<div class="pagination-centered">
					<nav class="navbar-inverse">
						<div class="navbar navbar-fixed-top navbar-inner ">
							<a class="brand" href="<?php echo $urlApps;?>logged/index.php"><i class="icon-home"></i></a>
							<ul class="nav pull-right">
								<li><a href="/ProjectFree/application/projeto.php">Projetos</a></li>
								<li><a href="/ProjectFree/application/mensagem.php">Mensagens</a></li>
								<li><a href="/ProjectFree/application/nota.php">Anotações</a></li>
								<li><a href="/ProjectFree/application/perfil.php">Meu perfil</a></li>
								<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
								<li><a href="/ProjectFree/application/login.php">Logout</a></li>
							</ul>
						</div>
					</nav>
					<h1>ProjectFree</h1>
				</div>
			<?php
			}
			else {
				?>
				<div class="pagination-centered">
					<nav class="navbar-inverse">
						<div class="navbar navbar-fixed-top navbar-inner ">
							<a class="brand" href="<?php echo $urlApps;?>index.php"><i class="icon-home"></i></a>
							<ul class="nav">
								<li class="brand">Nome do Projeto
								<li><a href="/ProjectFree/application/logged/cronograma.php">Cronograma</a></li>
								<li><a href="/ProjectFree/application/logged/fase.php">Fases</a></li>
								<li><a href="/ProjectFree/application/logged/atividade.php">Atividades</a></li>
								<li><a href="/ProjectFree/application/logged/membro.php">Membros</a></li>
								<li><a href="/ProjectFree/application/logged/artefato.php">Artefatos</a></li>
							</ul>
							<ul class="nav pull-right">
								<li><a href="/ProjectFree/application/logged/projeto.php">Projetos</a></li>
								<li><a href="/ProjectFree/application/mensagem.php">Mensagens</a></li>
								<li><a href="/ProjectFree/application/nota.php">Anotações</a></li>
								<li><a href="/ProjectFree/application/perfil.php">Meu perfil</a></li>
								<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
								<li><a href="/ProjectFree/application/login.php">Logout</a></li>
							</ul>
						</div>
					</nav>
					<h1>ProjectFree</h1>
				</div>
				<?php
			}
				?>
		</header>
			<?php
	}

	public static function setTitle($title) {
		self::$title = $title;
	}

	public static function setExtraHeader($extraHeader) {
		if (!isset(self::$extraHeader)) {
			self::$extraHeader = array();
		}
		self::$extraHeader[] = $extraHeader;
	}
}