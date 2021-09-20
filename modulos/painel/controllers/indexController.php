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

    public function index()
    {
        $this->redir('painel/dashboard');
    }
}
