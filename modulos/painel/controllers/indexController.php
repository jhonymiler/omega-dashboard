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
class indexController extends painelController
{
    //put your code here
    public function __construct()
    {
        parent::__construct();
    }

    public function index($id = false)
    {
        $con = $this->loadModel('painel', 'consultas');

        if (isset($_POST['CON_sql'])) {
            $con->gravaConsulta($_POST);
        }

        //$consulta = $con->getConsulta($id);
        $consultas = $con->getConsultas();

        exit();
        $this->_view->assign('consulta', $consulta);
        $this->_view->assign('consultas', $consultas);
        $this->_view->addConteudo('index');
        $this->_view->renderizar();
    }
}
