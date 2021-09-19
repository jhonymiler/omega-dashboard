<?php

/**
 * Config da aplicação
 * @author Jonatas Miler  <jonatasmiler@gmail.com>
 */

require_once 'app/config.php';


try { 
    Sessao::init();
    Sessao::set('msg',array());
    
    
    setlocale(LC_ALL, "pt_BR", "pt_BR.iso-8859-1", "pt_BR.utf-8", "portuguese");
    date_default_timezone_set('America/Sao_Paulo');
    
    $Registro = Registro::getInstancia();
    $Registro->_request = new Requisicao; 
    $Registro->_db = new Database;
    
    Ferramentas::rodar($Registro->_request);

} catch (Exception $e) {
    echo $e->getMessage();
}
