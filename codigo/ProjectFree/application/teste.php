
<!DOCTYPE HTML>

<html lang="pt-BR">
	<head>
		<meta charset='utf-8' />
		<title><?php echo $title ? $title . ' | ' : '';?>Project Free</title>
		<link rel="stylesheet" type="text/css" href="../resources/css/main.css" />
	</head>
	<body>
		<h1>
<?php

class Pessoa {
	public function __construct($var = 10) {
	}
	public function sayHi() {
		function sayHiAgain() {
			return 'hiAgain';
		}

		return sayHiAgain();
	}
}

$pessoa = new Pessoa();

//echo $pessoa->sayHi();

echo (new Pessoa())->sayHi();


?>
		</h1>
	</body>
</html>


