<?php

require_once 'main.php';

class Mensagem extends Main {
	public function __construct() {
		$this->setTitle('Mensagem');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->savarMensagem();
		}
		else {
			if (true) { //TODO Check gerente do projeto
				$this->atividadesGerente();
			}
			else {
				$this->atividadesGerente();
			}
		}
	}

	private function atividadesGerente() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="mensagens">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#mensagens">Últimas mensagens recebidas</a>
				 	</caption>
					<thead>
						<tr>
							<th>Enviado por</th>
							<th>Assunto</th>
						</tr>
					</thead>
					<tbody>
						<?php for($i=0; $i<10; $i++) {?>
						<tr>
							<td><?php echo 'Nome_remetente';?></td>
							<td><?php echo '_Assunto_';?></td>
						</tr>
						<?php }?>
					</tbody>
				</table>
			</div>
			<div class="span3">
				<a class="btn btn-primary btn-large" href="mensagem.php?novo=true">Enviar mensagem</a>
			</div>
		</div>
		<?php
	}

	private function savarMensagem() {
		?>
		<div class="container">
			<form action="<?php echo SAVE_FILE;?>" method="post">
				Assunto:
				<input type="text" data-type="text-simple" placeholder="Assunto" name="assunto" /> <br>

				Mensagem:
				<textarea data-type="text-multi" name="descricao"></textarea> <br>

				Enviar para:
				<input type="text" class="input-xlarge" data-type="text-autocomplete" placeholder="Comece a digitar" name="membro" /> <br>

				<button type="submit" class="btn btn-primary btn-large" name="submit">Enviar</button>
			</form>
		</div>
		<?php
	}

} new Mensagem();