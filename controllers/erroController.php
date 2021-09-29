<?php

class erroController extends Controller
{

    public function __construct()
    {
        parent::__construct();
    }

    public function index($cod = false)
    {
        Sessao::addMsg('erro', '404 - A página que vc tentou acessar não exite.');
        $this->redir('painel');
    }
}
