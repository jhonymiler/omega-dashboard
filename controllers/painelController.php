<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of pageControle
 *
 * @author Jonatas
 */
class painelController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        //$this->_view->assign('usuario', $usu_emp);

        if (!Sessao::get('logado')) {
            $this->redir('login');
            exit();
        }
        $this->_view->setTemplate(DEFAOULT_LAYOUT);

        $this->_view->assign('titulo', 'Painel de Administração');
        $this->_view->assign('sessaoUsuario', Sessao::get('user'));

        $this->_view->assign('codigo', $this->POST('codigo'));

        $this->_view->assign('current_link', 'home');
        $this->_view->addNavLink('painel', 'Home');
    }

    public function index()
    {
    }
}
