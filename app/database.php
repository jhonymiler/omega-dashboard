<?php

class Database
{
    public $conexao;

    public function __construct()
    {
        if ($db = Sessao::get('db')) {
            $this->getConnection($db);
        }
    }

    public function getConnection($conexao)
    {


        $pdoConfig  = "sqlsrv:" . "Server=" . $conexao['instancia'] . ";";
        $pdoConfig .= "Database=" . $conexao['banco'] . ";";

        try {
            if (!isset($this->conexao)) {
                $this->conexao =  new PDO($pdoConfig, $conexao['usuario'], $conexao['senha']);
                $this->conexao->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            }
            return $this->conexao;
        } catch (PDOException $e) {
            $mensagem = "Drivers disponiveis: " . implode(",", PDO::getAvailableDrivers());
            $mensagem .= "\nErro: " . $e->getMessage();
            Sessao::addMsg('erro', $e->getMessage());
            //throw new Exception($mensagem);
        }
    }
}
