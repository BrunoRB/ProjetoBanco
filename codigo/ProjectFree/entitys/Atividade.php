<?php

class Atividade {
	private $id_atividade;
	private $inicio_atividade;
	private $limite_atividade;
	private $fim_atividade;
	private $nome_atividade;
	private $descricao_atividade;
	private $fk_predecessora;
	private $fk_fase;
	private $finalizada;
	private $fk_projeto;

	public function getId_atividade()
	{
	    return $this->id_atividade;
	}

	public function setId_atividade($id_atividade)
	{
	    $this->id_atividade = $id_atividade;
	}

	public function getInicio_atividade()
	{
	    return $this->inicio_atividade;
	}

	public function setInicio_atividade($inicio_atividade)
	{
	    $this->inicio_atividade = $inicio_atividade;
	}

	public function getLimite_atividade()
	{
	    return $this->limite_atividade;
	}

	public function setLimite_atividade($limite_atividade)
	{
	    $this->limite_atividade = $limite_atividade;
	}

	public function getFim_atividade()
	{
	    return $this->fim_atividade;
	}

	public function setFim_atividade($fim_atividade)
	{
	    $this->fim_atividade = $fim_atividade;
	}

	public function getNome_atividade()
	{
	    return $this->nome_atividade;
	}

	public function setNome_atividade($nome_atividade)
	{
	    $this->nome_atividade = $nome_atividade;
	}

	public function getDescricao_atividade()
	{
	    return $this->descricao_atividade;
	}

	public function setDescricao_atividade($descricao_atividade)
	{
	    $this->descricao_atividade = $descricao_atividade;
	}

	public function getFk_predecessora()
	{
	    return $this->fk_predecessora;
	}

	public function setFk_predecessora($fk_predecessora)
	{
	    $this->fk_predecessora = $fk_predecessora;
	}

	public function getFk_fase()
	{
	    return $this->fk_fase;
	}

	public function setFk_fase($fk_fase)
	{
	    $this->fk_fase = $fk_fase;
	}

	public function getFinalizada()
	{
	    return $this->finalizada;
	}

	public function setFinalizada($finalizada)
	{
	    $this->finalizada = $finalizada;
	}

	public function getFk_projeto()
	{
	    return $this->fk_projeto;
	}

	public function setFk_projeto($fk_projeto)
	{
	    $this->fk_projeto = $fk_projeto;
	}
}