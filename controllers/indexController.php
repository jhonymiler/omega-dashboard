<?php

/**
 * Description of indexControle
 *
 * @author Jonatas
 */
class indexController extends Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        if (!Sessao::get('logado')) {
            $this->redir('login');
        } else {
            $this->redir('painel');
        }
    }
}
