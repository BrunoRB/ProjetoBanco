<?php


class PostgresConnection {
	private $host = 'localhost';
	private $port = '5432';
	private $databaseName = 'projectfree';
	private $user = 'admin';
	private $password = 'admin';
	private $connection;

	public function __construct() {
		$this->connection = pg_connect("host=$this->host dbname=$this->databaseName user=$this->user password=$this->password port=$this->port");
	}

	public function setConnection($host, $databaseName, $user, $password, $port = 5432) {
		$this->host = $host;
		$this->databaseName = $databaseName;
		$this->user = $user;
		$this->password = $password;
		$this->port = $port;
		$this->connect();
	}

	private function connect() {
		$this->connection = pg_connect("host=$this->host dbname=$this->databaseName user=$this->user password=$this->password port=$this->port");
	}

	public function getConnection() {
		return $this->connection;
	}

	public function closeConnection() {
		pg_close($this->connection);
	}

	/**
	 * Cria um prepare statement para uma função
	 *
	 * @param string $functionName nome da função
	 * @param int $numberOfParameters número de argumentos que a função contêm
	 * @return retorno de pg_prepare
	 */
	public function prepareFunctionStatement($functionName, $numberOfParameters) {
		$parameters = '$1';
		for ($i=2; $i<=$numberOfParameters; $i++) {
			$parameters .= ', $' . $i;
		}
		$parameters = $numberOfParameters > 0 ? $parameters : '';
		$statement = "SELECT $functionName ($parameters)";
		return pg_prepare($this->connection, $functionName, $statement);
	}

	public function prepareFunctionStatementSelect($functionName, $numberOfParameters) {
		$parameters = '$1';
		for ($i=2; $i<=$numberOfParameters; $i++) {
			$parameters .= ', $' . $i;
		}
		$parameters = $numberOfParameters > 0 ? $parameters : '';
		$statement = "SELECT * FROM $functionName ($parameters)";
		return pg_prepare($this->connection, $functionName, $statement);
	}

	/**
	 * Executa função após query ter sido preparada por prepareFunctionStatement
	 *
	 * @param string $functionName nome da função
	 * @param array $values valores a serem utilizados como parâmetros
	 * @return retorno de pg_execute
	 */
	public function executeFunctionStatement($functionName, array $values) {
		return pg_execute($this->connection, $functionName, $values);
	}

	public function getArrayOfResultsFromSelect($result) {
		$data = array();
		$rows = pg_num_rows($result);
		if ($rows > 0) {
			$cols = pg_num_fields($result);
			for ($i = 0; $i < $rows; $i++) {
				$data[] = pg_fetch_assoc($result, $i);
			}
		}
		return $data;
	}

	public function getTypes($result) {
		$types = array();
		$cols = pg_num_fields($result);
		for ($i = 0; $i < $cols; $i++) {
			$types[] = pg_field_type($result, $i);
		}
		return $types;
	}

	public function getNames($result) {
		$names = array();
		$cols = pg_num_fields($result);
		for ($i = 0; $i < $cols; $i++) {
			$names[] = pg_field_name($result, $i);
		}
		return $names;
	}

	/**
	 *
	 * @param unknown $query
	 * @param unknown $params
	 */
	public function executeQueryWithParams($query, $params) {
		return pg_query_params($this->connection, $query, $params);
	}

	public function getResult($result) {
		return pg_fetch_all($result);
	}

	public function getErrorString() {
		return pg_last_error($this->connection);
	}

	public function getNoticeString() {
		return pg_last_notice($this->connection);
	}

}
