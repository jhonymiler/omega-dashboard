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
class empresasModulo extends Model
{

    //put your code here
    public $erro;

    private $tabela = 'empresas';
    private $empresa = array();

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
    public function getEmpresaID($id)
    {
        $this->empresa =  $this->_db->_select('EMP_id', $id);
        $endereco = explode(', ', $this->empresa[0]['EMP_endereco']);
        $this->empresa[0]['rua'] = $endereco[0];
        $this->empresa[0]['numero'] = $endereco[1];
        return $this->empresa;
    }
    public function load($campos)
    {
        $campos['EMP_endereco'] = $campos['rua'] . ', ' . $campos['numero'];
        return $this->_db->_load($campos);
    }
    public function atualiza($id)
    {
        return $this->_db->_atualiza('EMP_id', $id);
    }
    public function excluir($id)
    {
        if (is_numeric($id)) {
            return $this->_db->_delete('EMP_id', $id);
        } elseif (is_array($id) && count($id) > 0) {
            return $this->_db->_query('DELETE FROM empresas WHERE EMP_id IN (' . implode(',', $id) . ')');
        }
    }
    public function getErro()
    {
        return $this->erro = $this->_db->_getErro();
    }
}
