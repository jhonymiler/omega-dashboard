<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * REQUISIÇÃO DE PARAMETROS PASSADOS POR HTTP
 *
 * Classe para pegar GETs, POSTs, PUTs ou DELETEs passado via http request
 *
 * @author Jonatas
 */

class request
{
    private $params = array();
    private $tipo = '';

    public function __construct()
    {
        $this->_parseParams();
    }

    /**
      * @param string $name Nome do argumento para visualização
      * @param mixed $default Retorna vazio se não existir a requisição pedida
      * @returns =  Retorna todos os valores GET/POST/PUT/DELETE , ou Deflt como vazio
      */
    public function get($name = null)
    {
        if (isset($this->params[$name])) {
            return $this->scape($this->params[$name]);
        } else {
            return $this->scape($this->params);
        }
    }
  
    /**
     * Escapa as entradas
     *
     * Trata as variáveis passadas
     */
    public function scape($param)
    {
        if (is_array($param)) {
            foreach ($param as $key=>$val) {
                $param[$key] = $this->scape($val);
            }
        } else {
            $param = addslashes($param);
        }
    
        return  $param;
    }


    /**
     * Pega o tipo da requisição para análise posterior
     */
    public function getType()
    {
        return $this->tipo;
    }

    private function _parseParams()
    {
        $method = $_SERVER['REQUEST_METHOD'];
        switch ($_SERVER['REQUEST_METHOD']) {
            case 'GET':
                $this->params = $_GET;
                $this->tipo = 'GET';
                    break;
            case 'POST':
                $this->params = $_POST;;
                $this->tipo = 'POST';
                    break;
            case 'PUT':
                parse_str(file_get_contents('php://input'), $this->params);;
                $this->tipo = 'PUT';
                    break;
            case 'DELETE':
                parse_str(file_get_contents('php://input'), $this->params);;
                $this->tipo = 'DELETE';
                    break;
    }
    }
}
