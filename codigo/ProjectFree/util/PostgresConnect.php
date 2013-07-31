<?php


class PostgresConnect{
	protected $host;
	protected $port;
	protected $databaseName;
	protected $user;
	protected $password;
	protected $connection;

	public function __construct($host, $databaseName, $user, $password, $port = 5432) {
		$this->host = $host;
		$this->databaseName = $databaseName;
		$this->user = $user;
		$this->password = $password;
		$this->port = $port;
	}

	protected function connect() {
		$connection = pg_connect("$this->host ");
	}

}