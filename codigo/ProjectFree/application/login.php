<?php

include_once '../templates/header.php';

?>
<div class="container">

	<div class="container">
		<form class="form-horizontal" method="post" action="">
			<div class="control-group">
				<label class="control-label" for="inputEmail">Email</label>
				<div class="controls">
					<input type="text" id="inputEmail" placeholder="Email">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputPassword">Password</label>
				<div class="controls">
					<input type="password" id="inputPassword" placeholder="Password">
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<label class="checkbox"> <input type="checkbox"> Manter logado
					</label>
					<button type="submit" class="btn btn-success btn-medium">Logar</button>
				</div>
			</div>
		</form>
	</div>

</div>
<?php

include_once '../templates/footer.php';