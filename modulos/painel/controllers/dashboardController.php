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
    public $user;
    //put your code here
    public function __construct()
    {

        parent::__construct();
        $this->con = $this->loadModel('painel', 'consultas');
        $this->user = $this->loadModel('painel', 'usuario');
    }

    public function index($id = false)
    {


        if (isset($_POST['CON_sql'])) {
            $this->con->gravaConsulta($_POST);
        }

        $consultas = $this->con->getConsultas();
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
            $this->redir('painel/dashboard/index/' . $consultas[0][0]);
        }

        $userList = $this->user->listaUsuarios();


        $this->_view->assign('userList', $userList);
        $this->_view->assign('consultas', $consultas);
        $this->_view->assign('msg', Sessao::getMsg(true));
        $this->_view->addConteudo('index');
        $this->_view->renderizar();
    }

    public function excluir($id = false)
    {
        if ($id) $this->con->excluirConsulta($id);
        $this->redir('painel');
    }

    public function editor($id = false)
    {
        if (Sessao::get('tema')) {
            $this->_view->assign('tema', Sessao::get('tema'));
        } else {
            $this->tema('vs-dark');
            $this->_view->assign('tema', 'vs-dark');
        }

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

    public function tema($tema = false)
    {
        if ($tema) {
            Sessao::set('tema', $tema);
        }

        if (Sessao::get('tema')) {
            echo Sessao::get('tema');
        } else {
            echo $this->tema('vs-dark');
        }
    }
}
