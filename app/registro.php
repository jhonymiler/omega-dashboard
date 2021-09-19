<?php

/*
 * -------------------------------------
 * www.dlancedu.com | Jaisiel Delance
 * framework mvc basico
 * Registry.php
 * -------------------------------------
 */

class Registro
{
    private static $_instancia;
    private $_data;
    
    //Esta classe não pode ser insanciada
    private function __construct()
    {
    }
    
    //singleton
    public static function getInstancia()
    {
        if (!self::$_instancia instanceof self) {
            self::$_instancia = new Registro();
        }
        return self::$_instancia;
    }
    
    public function __set($name, $value)
    {
        $this->_data[$name] = $value;
    }
    
    public function __get($name)
    {
        if (isset($this->_data[$name])) {
            return $this->_data[$name];
        }
        
        return false;
    }
}
