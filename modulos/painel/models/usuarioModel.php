<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of usuarioModel
 *
 * @author Jonatas
 */
class usuarioModel extends Model
{

    public $perm;

    public function __construct()
    {
        $this->perm = array();
        parent::__construct();
    }

    public function getPermissaoLogin($id_usuario = false)
    {
        if ($id_usuario) {

            if ($id_usuario == 'OMEGA') {
                return true;
            } else {
                $query = $this->_db->prepare("SELECT PER_ver FROM Permissao_Dashboard where codigo=:id and PER_ver <> '0';");
                $query->execute(
                    array(':id' => $id_usuario)
                );
                if (count($query->fetchAll(PDO::FETCH_ASSOC)) > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    /**
     * Busca as permissões do usuário
     *
     * @param 'string' $id_usuario
     *
     * @return array
     */
    public function getPermissoes($id_usuario = false)
    {


        if ($id_usuario) {
            if ($id_usuario == 'OMEGA') {
                $query = $this->_db->prepare("SELECT distinct CON_id FROM Permissao_Dashboard");
                $query->execute();

                $permissoes = $query->fetchAll(PDO::FETCH_ASSOC);

                if (is_array($permissoes) && count($permissoes) > 0) {
                    foreach ($permissoes as $k => $consultas) {
                        $this->perm[$consultas['CON_id']] = array(
                            'PER_incluir' => TRUE,
                            'PER_excluir' => TRUE,
                            'PER_ver' => TRUE,
                            'PER_editar_permissao' => TRUE
                        );
                    }

                    return $this->perm;
                } else {
                    return false;
                }
            } else {
                $query = $this->_db->prepare("SELECT * FROM Permissao_Dashboard where codigo=:id");
                $query->execute(
                    array(':id' => $id_usuario)
                );

                $permissoes = $query->fetchAll(PDO::FETCH_ASSOC);

                if (is_array($permissoes) && count($permissoes) > 0) {
                    foreach ($permissoes as $k => $consultas) {
                        foreach ($consultas as $campos => $valor) {
                            $this->perm[$consultas['CON_id']][$campos] = $valor;
                        }
                    }

                    return $this->perm;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    public function listaUsuarios()
    {
        $query = $this->_db->prepare("SELECT codigo,senha,niveloper,nomecompleto FROM senhas ORDER BY descricao");
        $query->execute();
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
}
