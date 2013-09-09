<?php

class Fase {
	private $id_fase;
	private $nome;
	private $descricao;
	private $fk_projeto;
	private $fk_predecessora;

	public function getId_fase()
	{
	    return $this->id_fase;
	}

	public function setId_fase($id_fase)
	{
	    $this->id_fase = $id_fase;
	}

	public function getNome()
	{
	    return $this->nome;
	}

	public function setNome($nome)
	{
	    $this->nome = $nome;
	}

	public function getDescricao()
	{
	    return $this->descricao;
	}

	public function setDescricao($descricao)
	{
	    $this->descricao = $descricao;
	}

	public function getFk_projeto()
	{
	    return $this->fk_projeto;
	}

	public function setFk_projeto($fk_projeto)
	{
	    $this->fk_projeto = $fk_projeto;
	}

	public function getFk_predecessora()
	{
	    return $this->fk_predecessora;
	}

	public function setFk_predecessora($fk_predecessora)
	{
	    $this->fk_predecessora = $fk_predecessora;
	}
}