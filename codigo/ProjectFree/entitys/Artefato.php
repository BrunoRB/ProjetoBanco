<?php

class Artefato {
	private $id_artefato;
	private $nome;
	private $tipo;
	private $descricao;
	private $porcentagem_concluida;

	public function getId_artefato()
	{
	    return $this->id_artefato;
	}

	public function setId_artefato($id_artefato)
	{
	    $this->id_artefato = $id_artefato;
	}

	public function getNome()
	{
	    return $this->nome;
	}

	public function setNome($nome)
	{
	    $this->nome = $nome;
	}

	public function getTipo()
	{
	    return $this->tipo;
	}

	public function setTipo($tipo)
	{
	    $this->tipo = $tipo;
	}

	public function getDescricao()
	{
	    return $this->descricao;
	}

	public function setDescricao($descricao)
	{
	    $this->descricao = $descricao;
	}

	public function getPorcentagem_concluida()
	{
	    return $this->porcentagem_concluida;
	}

	public function setPorcentagem_concluida($porcentagem_concluida)
	{
	    $this->porcentagem_concluida = $porcentagem_concluida;
	}
}