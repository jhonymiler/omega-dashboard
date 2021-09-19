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
class departamentosModulo extends Model
{

    //put your code here
    public $erro;

    private $tabela = 'departamentos';
    private $departamento = array();

    public function __construct()
    {
        parent::__construct();


        //constroi o objeto registro
        $this->_db->_setTabela($this->tabela);
    }

    public function lista()
    {
        return $this->_db->_select();
    }
    public function getDepartamentoID($id)
    {
        $this->departamento =  $this->_db->_select('DEP_id', $id);
        return $this->departamento;
    }
    public function load($campos)
    {
        return $this->_db->_load($campos);
    }
    public function atualiza($id)
    {
        return $this->_db->_atualiza('DEP_id', $id);
    }
    public function excluir($id)
    {
        if (is_numeric($id)) {
            return $this->_db->_delete('DEP_id', $id);
        } elseif (is_array($id) && count($id) > 0) {
            return $this->_db->_query('DELETE FROM departamentos WHERE DEP_id IN (' . implode(',', $id) . ')');
        }
    }
    public function getErro()
    {
        return $this->erro = $this->_db->_getErro();
    }
}
