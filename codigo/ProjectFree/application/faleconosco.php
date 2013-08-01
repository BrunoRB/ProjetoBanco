<?php

include_once '../templates/body.php';

class FaleConosco extends Body {

	public function loadBody() {
		$var = 120;
		$heredoc = <<<EOF
		<h1>HELLO $var</h1>
EOF;
		echo $heredoc;
	}
} new FaleConosco();