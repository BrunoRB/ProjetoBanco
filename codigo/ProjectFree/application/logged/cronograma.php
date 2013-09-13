<?php

require_once 'main.php';

class Page_Cronograma extends Main {

	public function __construct() {
		$this->setTitle('Cronograma');
		parent::__construct();
	}

	protected function listar() {
		?>
			<div class="row-fluid">
				<div class="span11 collapse-group accordion-group" id="<?php echo $this->getEntity();?>">
					<table class="table table-hover-mod">
						<caption>
							<a data-toggle="collapse" data-target="<?php echo '#' . $this->getEntity();?>">
								<h2><?php echo ucfirst($this->getEntity());?></h2>
							</a>
						</caption>
						<thead>
							<?php
							echo '<tr>';
							foreach ($this->getListarNames() as $colName) {
								echo '<td>' . $colName . '</td>';
							}
							echo '</tr>';
							?>
						</thead>
						<tbody>
							<?php
							foreach($this->getListarData() as $row) {
								echo '<tr class="list">';
									foreach ($row as $colKey => $colVal) {
										$siglaId = 'id_' . $this->getEntity();
										echo '<td>';
										echo $colVal;
										echo '</td>';
									}
								echo '</tr>';
							}
							?>
						</tbody>
					</table>
				</div>
			</div>
			<?php
		}
		
} new Page_Cronograma();

