<?php

class Database
{
    private $conexao;

    public function __construct()
    {
    }

    public function getConnection($host, $db, $user, $senha)
    {

        $pdoConfig  = "sqlsrv:" . "Server=" . $host . ";";
        $pdoConfig .= "Database=" . $db . ";";

        try {
            if (!isset($this->conexao)) {
                $this->conexao =  new PDO($pdoConfig, $user, $senha);
                $this->conexao->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            }
            return $this->conexao;
        } catch (PDOException $e) {
            $mensagem = "Drivers disponiveis: " . implode(",", PDO::getAvailableDrivers());
            $mensagem .= "\nErro: " . $e->getMessage();
            throw new Exception($mensagem);
        }
    }
}
