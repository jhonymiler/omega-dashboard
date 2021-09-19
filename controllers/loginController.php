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
class loginController extends Controller
{
    protected $_user;
    public $_info;

    //put your code here
    public function __construct()
    {
        parent::__construct();
        $this->_user = $this->loadModel('login');
    }

    public function index()
    {
        Sessao::set('logado', false);

        $this->_view->assign('titulo', APP_NOME . ' - LOGIN');
        $this->_view->assign('infs', $this->_user->dados);
        $this->_view->display($this->_view->getPath('view') . 'login.tpl');
    }

    public function acesso()
    {
        Sessao::set('logado', false);

        $db = $this->_user->dados[$this->POST('banco')];
        Sessao::set('db', $db);
        $Conexao  = $this->_db->getConnection($db);

        if (!$this->POST('user')) {
            $assign = addMsg('_error', 'Digite um nome de Usuário');
        } elseif (!$this->POST('pass')) {
            $this->_view->assign('_error', 'Digite uma senha');
        } else {

            $user = $Conexao->prepare("SELECT NomeCompleto,senha FROM senhas where codigo=:usr");
            $user->execute(array(':usr' => $this->POST('user')));
            $usr = $user->fetchAll()[0];
            if (!is_array($usr)) {
                $this->_view->assign('_error', 'Usuário ou senha incorretos');
            } else {
                if ($usr['senha'] == $this->_user->senhaEncrypt($this->POST('pass'))) {
                    // se a senha for verdadeira

                    Sessao::set('logado', true);
                    $usuario = array(
                        'nome'           => $usr['NomeCompleto'],
                        'sessao'         => time()
                    );
                    Sessao::set('user', $usuario);
                } else {
                    $this->_view->assign('_error', 'Usuário ou senha incorretos');
                }
            }
        }

        if (Sessao::get('logado') == true) {
            $this->redir('painel');
            exit();
        } else {
            $this->index();
        }
    }


    public function sair()
    {
        Sessao::destroy();
        $this->redir('login');
    }
}
