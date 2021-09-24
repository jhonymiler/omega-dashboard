<?php

/**
 * ferramenta para manipulação das sessões da pagina
 */

class Sessao
{
    /**
     * inicia uma sessão
     */
    public static function init()
    {
        if (!isset($_SESSION)) {
            session_start();

            $_SESSION['id'] = time();
        }
    }
    /**
     *
     * Seta uma nova sessão ou atualiza uma existente
     *
     * @param type $chave = chave da sessão
     * @param type $valor = valor da sessao
     */
    public static function set($chave, $valor)
    {
        $_SESSION[$chave] = $valor;
    }

    /**
     *
     * Pega o valor de uma sessão
     *
     * @param type $chave = nome da sessão
     * @return type *
     */
    public static function get($chave)
    {
        if (isset($_SESSION[$chave])) {
            return $_SESSION[$chave];
        } else {
            return false;
        }
    }



    // DERTERMINA O TEMPO DE ACESSO
    public static function tempo()
    {
        if (!defined('TIME')) {
            throw new Exception('O tempo da sessão não foi definido');
        }

        if (TIME == 0) {
            return;
        }

        if (time() - Sessao::get('tempo') > (TIME * 60)) {
            Sessao::destroy();
            header('location:' . BASE_URL . 'login');
        } else {
            Session::set('tempo', time());
        }
    }

    public static function addMsg($tipo = 'sucesso', $msg = '')
    {
        $status = '';
        switch ($tipo) {
            case 'erro':
                $status = 'bg-danger';
                break;
            case 'sucesso':
                $status = 'bg-success';
                break;
            case 'alerta':
                $status = 'bg-warning';
                break;
            case 'info':
                $status = 'bg-info';
                break;
            default:
                $status = 'bg-info';
                break;
        }

        $_SESSION['msg'][] = array(
            'tipo' => $status,
            'msg' => $msg
        );
    }

    public static function getMsg($limpa = false)
    {
        $msg = is_array($_SESSION['msg']) ? $_SESSION['msg'] : '';
        if ($limpa === true) $_SESSION['msg'] = array();
        return $msg;
    }

    /**
     * destroi uma ou todas as sessões
     * se passar a $chave, estão destruirá somente a sessão chamada
     * @param type $chave =  chave de uma sessão
     */
    public static function destroy($chave = false)
    {
        if ($chave == false) {
            session_destroy();
        } else {
            if (is_array($chave)) {
                foreach ($chave as $ch) {
                    unset($_SESSION[$ch]);
                }
            } else {
                unset($_SESSION[$chave]);
            }
        }
    }
}
