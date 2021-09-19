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
class consultasModel extends Model
{
    public $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->_db->conexao;
    }

    /**
     * Grava os scripts na tabela consulta
     *
     * @param [TEXT] $sql
     * @param [TEXT] $javascript
     * @param INT $id
     *
     * @return void
     */
    public function gravaConsulta($dados)
    {
        if ($dados['id'] == '') {
        } else {
            $query = $this->db->prepare("    
                insert into Consulta_Dashboard 
                (CON_titulo,CON_sql,CON_javascript) 
                values ('?','?','?')
            ");
            $resultado = $query->execute(
                array(
                    $dados['CON_titulo'],
                    $dados['CON_sql'],
                    $dados['CON_javascript']
                )
            );
        }
        print_r($resultado);
    }

    public function getConsultas()
    {
        $query = $this->db->prepare("select * from Consulta_Dashboard");
        $query->execute();
        print_r($query->fetchAssoc());
    }

    public function getConsulta($id = false)
    {
        if ($id) {
            $query = $this->db->prepare("select * from Consulta_Dashboard");
            $query->execute();
        }

        $arr = array();
        while ($row = $query->fetch()) {
            $arr[] = '{x: new Date("' . $row[0] . '"), y: ' . $row[1] . '}';
        }
        return '[' . implode(',', $arr) . ']';
    }
}
