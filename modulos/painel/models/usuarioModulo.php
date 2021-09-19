<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of usuarioModulo
 *
 * @author Jonatas
 */
class usuarioModulo extends Model
{

    //put your code here
    public $erro;

    private $tabela = 'usuarios';
    private $usuario;
    public $info = "";

    public function __construct()
    {
        parent::__construct();


        //constroi o objeto registro
        $this->_db->_setTabela($this->tabela);

        /*----------------CONFIG USUARIO------------------*/
        // INICIA A CONFIGURAÇÃO BADICA
        $this->info = array(
            'USU_nome'  => 'Seu Nome',
            'USU_email' => 'exemplo@email.com',
        );

        $this->_db->_load($this->info);
    }
    // carrega o array com os campos e valores na classe
    public function _load($usuario)
    {
        if (isset($usuario['USU_senha']) && $usuario['USU_senha'] != '') {
            $usuario['USU_senha'] = md5($usuario['USU_senha']);
        } elseif (isset($usuario['USU_senha']) && $usuario['USU_senha'] == '') {
            unset($usuario['USU_senha']);
        }

        $this->_db->_load($usuario);
    }
    // seleciona usuário
    public function _selectUser()
    {
        $args = func_get_args();
        $this->usuario = $this->_db->_select($args[0], $args[1]);
        return $this->usuario;
    }

    public function _excluir($id)
    {
        if (is_numeric($id)) {
            return $this->_db->_delete('USU_id', $id);
        }
    }

    public function listaUsuarios()
    {
        return $this->_db->_query(
            "SELECT * FROM usuarios AS U LEFT OUTER JOIN empresas AS E ON E.EMP_id=U.EMP_id;"
        );
    }

    public function base64ToImage($base64_string)
    {
        $output_file = RAIZ . 'upload/saida.PNG';

        if (!file_exists($output_file)) {
            imagecreatefrompng($output_file);
        }
        $file = fopen($output_file, "wb");

        $data = explode(',', $base64_string);
        fwrite($file, base64_decode($data[1]));
        fclose($file);

        return $output_file;
    }

    public function upImagem()
    {
        $nome = $this->slug($this->_get('USU_nome'));
        $data = $this->base64ToImage($this->_get('USU_imagem'));
        if ($data) {
            require_once RAIZ . 'lbs' . DS . 'classes' . DS . 'upload.php';
            $handle = new upload($data);
            $handle->file_max_size = '5000000';
            $handle->file_new_name_body = $nome . '_' . time();
            $handle->image_resize = true;
            $handle->image_x = 180;
            $handle->image_ratio_y = true;
            $handle->process(RAIZ . 'upload/');
            if ($handle->processed) {
                $this->_set('USU_imagem', $handle->file_dst_name);
                return $handle->file_dst_name;
                $handle->clean();
            } else {
                return false;
            }
        }
    }



    public function getEmpresa($usuarioID)
    {
        $usuarios = $this->_db->_query(
            "SELECT * FROM usuarios AS U LEFT OUTER JOIN empresas AS E ON E.EMP_id=U.EMP_id where USU_id='" . $usuarioID . "'"
        );
        return $usuarios[0];
    }


    public function _grava()
    {
        $idAtual = $this->_get('USU_id');
        $note = array();
        if ($this->_userExiste($idAtual)) {
            return  $this->_db->_atualiza();
            $note['tipo'] = '_sucesso';
            $note['msg']  = 'Atualizado com sucesso!';
        } else {
            return  $this->_db->_grava();
            $note['tipo'] = '_sucesso';
            $note['msg']  = 'Gravado com sucesso!';
        }
        return $note;
    }


    public function _atualiza($id)
    {
        return  $this->_db->_atualiza('USU_id', $id);
    }


    private function _userExiste($id)
    {
        if (is_numeric($id)) {
            $user = $this->_db->_select($id);
            if (is_array($user) && count($user) > 0) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }



    // pega os erros do mysql;
    public function _getErro()
    {
        return $this->erro .= $this->_db->_getErro();
    }

    public function _validToken($token)
    {
        if (md5($this->_get('USU_email')) == $token) {
            return true;
        } else {
            return false;
        }
    }


    public function _set()
    {
        $args = func_get_args();
        $this->_db->_set($args[0], $args[1]);
        $this->usuario = $this->_db->_getReg();
    }

    public function _get()
    {
        $args = func_get_args();
        $reg = $this->_db->_getReg();
        if (count($args) == 1) {
            if (isset($reg[$args[0]])) {
                $reg =  $reg[$args[0]];
            }
        }
        return  $reg;
    }
}
//$array = array(
//    "nome"=>"Rafel",
//    "email"=>"jonatas@officeweb.com.br",
//    "facebook"=>"jonatas.m.o"
//);
//$user = new usuario(10);
//print_r($user);
//$user->_selectUser('login','asdf');
//
//$user->_set("nome","amborsio");
//print_r($user->_get('nome'));

//print_r($user);
