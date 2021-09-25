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
        }
    }

    public function index()
    {
    }
}
