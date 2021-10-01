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
        $this->_view->assign('msg', Sessao::getMsg(true));
        $this->_view->display($this->_view->getPath('view') . 'login.tpl');
    }

    public function acesso()
    {
        Sessao::set('logado', false);

        if (!$this->POST('user')) {
            $this->_view->assign('_error', 'Digite um nome de Usuário');
        } elseif (!$this->POST('pass')) {
            $this->_view->assign('_error', 'Digite uma senha');
        } elseif ($this->POST('banco') == 'banco') {
            $this->_view->assign('_error', 'Selecione uma base de dados.');
        } else {

            $db = $this->_user->dados[$this->POST('banco')];
            Sessao::set('db', $db);
            $Conexao  = $this->_db->getConnection($db);


            $user = $Conexao->prepare("SELECT NomeCompleto,senha,codigo FROM senhas where codigo=:usr");

            if ($user->execute(array(':usr' => $this->POST('user')))) {
                $usr = $user->fetch();
                if (!is_array($usr)) {
                    $this->_view->assign('_error', 'Usuário ou senha incorretos');
                } else {
                    if ($usr['senha'] == $this->_user->senhaEncrypt($this->POST('pass'))) {
                        // se a senha for verdadeira

                        Sessao::set('logado', true);
                        $usuario = array(
                            'nome'           => $usr['NomeCompleto'],
                            'codigo'         => $usr['codigo'],
                            'sessao'         => time()
                        );
                        Sessao::set('user', $usuario);
                        Sessao::tempo(); // Determina o tempo de inatividade da sessão
                    } else {
                        $this->_view->assign('_error', 'Usuário ou senha incorretos');
                    }
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

    public function senha()
    {
        if (Sessao::get('logado')) {

            try {

                if ($this->POST('senha') == $this->POST('confirma')) {

                    $Conexao  = $this->_db->getConnection(Sessao::get('db'));

                    $user = $Conexao->prepare("SELECT senha FROM senhas where codigo=:usr");
                    $user->execute(array(':usr' => Sessao::get('user')['codigo']));
                    $usr = $user->fetch();

                    // verifica se a senha antiga está correta
                    if ($usr['senha'] == $this->_user->senhaEncrypt($this->POST('senha_atual'))) {

                        $user = $Conexao->prepare("UPDATE senhas set senha=:senha where codigo=:usr");
                        $grava = $user->execute(
                            array(
                                ':usr' => Sessao::get('user')['codigo'],
                                ':senha' => $this->_user->senhaEncrypt($this->POST('senha'))
                            )
                        );
                        if (!$grava) {
                            Sessao::addMsg('erro', 'A senha não foi gravada!');
                        } else {
                            Sessao::addMsg('sucesso', 'A senha foi gravada com sucesso!');
                        }
                    } else {
                        Sessao::addMsg('erro', 'Senha atual incorreta!');
                    }
                }
            } catch (PDOException $e) {
                Sessao::addMsg('erro', addslashes($e->getMessage()));
            }

            $this->redir('painel');
        } else {
            $this->index();
        }
    }

    public function timeout()
    {
        // função vazia apenas para pingar e verificar se a sessão já expirou
    }


    public function sair()
    {
        Sessao::destroy();
        $this->redir('login');
    }
}
