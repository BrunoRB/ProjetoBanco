<?php

require_once ('PHPUnit/Framework/TestCase.php');

require_once '../entitys/Usuario.php';


class UsuarioTest extends PHPUnit_Framework_Test_Case {
	protected $object;


	protected function setUp() {
		$this->object = new Usuario();
	}

	protected function tearDown() {

	}


	public function testUsuarioSets() {
		echo 'Teste usuário';
		$this->assertTrue($this->object->checkLoginFields());
	}
}