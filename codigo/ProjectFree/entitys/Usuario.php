<?php

class Usuario {
	private $id_usuario;
	private $nome;
	private $login;
	private $senha;
	private $inativo;
	private $data_inatividade;
	private $fk_imagem;

	public function getId_usuario()
	{
	    return $this->id_usuario;
	}

	public function setId_usuario($id_usuario)
	{
	    $this->id_usuario = $id_usuario;
	}

	public function getNome()
	{
	    return $this->nome;
	}

	public function setNome($nome)
	{
	    $this->nome = $nome;
	}

	public function getLogin()
	{
	    return $this->login;
	}

	public function setLogin($login)
	{
	    $this->login = $login;
	}

	public function getSenha()
	{
	    return $this->senha;
	}

	public function setSenha($senha)
	{
	    $this->senha = $senha;
	}

	public function getInativo()
	{
	    return $this->inativo;
	}

	public function setInativo($inativo)
	{
	    $this->inativo = $inativo;
	}

	public function getData_inatividade()
	{
	    return $this->data_inatividade;
	}

	public function setData_inatividade($data_inatividade)
	{
	    $this->data_inatividade = $data_inatividade;
	}

	public function getFk_imagem()
	{
	    return $this->fk_imagem;
	}

	public function setFk_imagem($fk_imagem)
	{
	    $this->fk_imagem = $fk_imagem;
	}

}