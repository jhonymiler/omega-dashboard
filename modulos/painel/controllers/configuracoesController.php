<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of indexControle
 *
 * @author Jonatas
 */
class configuracoesController extends painelController
{
    //put your code here
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $this->_view->assign('codigo', $_POST['codigo']);

        $this->_view->addConteudo('config');
        $this->_view->renderizar();
    }
}
