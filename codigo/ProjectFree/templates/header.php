<?php

/**
 *
 */
require_once '../util/PostgresConnect.php';

class Header{

	public static function loadHead($title) {
		?>
<!DOCTYPE HTML>

<html lang="pt-BR">
	<head>
		<meta charset='utf-8' />
		<title><?php echo $title ? $title . ' | ' : '';?>Project Free</title>

		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/bootstrap-responsive.css" />
		<link rel="stylesheet" href="/ProjectFree/resources/fonts/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/ProjectFree/resources/css/main.css" />

		<script type="text/javascript" src="/ProjectFree/resources/js/jquery-2.0.2.js"></script>
		<script type="text/javascript" src="/ProjectFree/resources/js/bootstrap.js"></script>
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
							<ul class="nav">
								<li><a href="/ProjectFree/application/sobre.php">Sobre</a></li>
								<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
							</ul>
							<ul class="nav">
								<li><a href="/ProjectFree/application/cadastro.php">Cadastrar</a></li>
								<li><a href="/ProjectFree/application/login.php">Logar</a></li>
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
								<li><a href="/ProjectFree/application/sobre.php">Sobre</a></li>
								<li><a href="/ProjectFree/application/faleconosco.php">Fale conosco</a></li>
							</ul>
							<ul class="nav">
								<li><a href="/ProjectFree/application/cadastro.php">Cadastrar</a></li>
								<li><a href="/ProjectFree/application/login.php">Logar</a></li>
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
}