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
class dashboardController extends painelController
{
    public $con;
    //put your code here
    public function __construct()
    {
        parent::__construct();
        $this->con = $this->loadModel('painel', 'consultas');
    }

    public function index($id = false)
    {

        if (isset($_POST['CON_sql'])) {
            $this->con->gravaConsulta($_POST);
        }

        if ($id) {
            $consulta = $this->con->getConsulta($id);
            $this->_view->assign('consulta_personalizada', $consulta);
        } else {
            $dados = array(
                'CON_id' => '',
                'CON_titulo' => '',
                'CON_sql' => '',
                'CON_javascript' => '',
            );
            $this->_view->assign('consulta_personalizada', $dados);
            $this->redir('painel/dashboard/index/13');
        }

        $consultas = $this->con->getConsultas();

        $this->_view->assign('consultas', $consultas);
        $this->_view->addConteudo('index');
        $this->_view->renderizar();
    }

    public function editor($id = false)
    {
        if ($id) {
            $consulta = $this->con->getConsulta($id);
        } else {
            $consulta = array(
                'CON_id' => '',
                'CON_titulo' => '',
                'CON_sql' => '',
                'CON_javascript' => '',
            );
        }

        $this->_view->assign('consulta_personalizada', $consulta);
        $this->_view->display($this->_view->getPath('view') . 'editor.tpl');
    }
}
