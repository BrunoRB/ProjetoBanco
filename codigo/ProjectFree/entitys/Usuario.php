<?php

class Usuario {
	private $id_usuario;
	private $nome;
	private $email;
	private $senha;
	private $inativo;
	private $imagem;
	private $data_inatividade;

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

	public function getEmail()
	{
	    return $this->email;
	}

	public function setEmail($email)
	{
	    $this->email = $email;
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

	public function getImagem()
	{
	    return $this->imagem;
	}

	public function setImagem($imagem)
	{
	    $this->imagem = $imagem;
	}

	public function getData_inatividade()
	{
	    return $this->data_inatividade;
	}

	public function setData_inatividade($data_inatividade)
	{
	    $this->data_inatividade = $data_inatividade;
	}
}