<?php

class Projeto {
	private $id_projeto;
	private $nome;
	private $orcamento;
	private $data_de_cadastro;
	private $descricao;
	private $data_de_termino;
	private $idGerente;

	public function getId_projeto()
	{
	    return $this->id_projeto;
	}

	public function setId_projeto($id_projeto)
	{
	    $this->id_projeto = $id_projeto;
	}

	public function getNome()
	{
	    return $this->nome;
	}

	public function setNome($nome)
	{
	    $this->nome = $nome;
	}

	public function getOrcamento()
	{
	    return $this->orcamento;
	}

	public function setOrcamento($orcamento)
	{
	    $this->orcamento = $orcamento;
	}

	public function getData_de_cadastro()
	{
	    return $this->data_de_cadastro;
	}

	public function setData_de_cadastro($data_de_cadastro)
	{
	    $this->data_de_cadastro = $data_de_cadastro;
	}

	public function getDescricao()
	{
	    return $this->descricao;
	}

	public function setDescricao($descricao)
	{
	    $this->descricao = $descricao;
	}

	public function getData_de_termino()
	{
	    return $this->data_de_termino;
	}

	public function setData_de_termino($data_de_termino)
	{
	    $this->data_de_termino = $data_de_termino;
	}

	public function getIdGerente()
	{
	    return $this->idGerente;
	}

	public function setIdGerente($idGerente)
	{
	    $this->idGerente = $idGerente;
	}
}