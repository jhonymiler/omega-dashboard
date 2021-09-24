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

    public function __construct()
    {
        parent::__construct();
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
        if ($dados['CON_id'] == '') {
            unset($dados['CON_id']);
            $query = $this->_db->prepare("    
                insert into Consulta_Dashboard 
                (CON_titulo,CON_sql,CON_javascript) 
                values (:titulo,:sql,:javascritp)
            ");
            $query->execute(
                array(
                    ':titulo' => $dados['CON_titulo'],
                    ':sql' => $dados['CON_sql'],
                    ':javascritp' => $dados['CON_javascript']
                )
            );
        } else {
            $query = $this->_db->prepare("    
                update Consulta_Dashboard 
                set CON_titulo=:titulo,CON_sql=:sql,CON_javascript=:javascript
                where CON_id=:id ;
            ");
            $query->execute(
                array(
                    ':titulo' => $dados['CON_titulo'],
                    ':sql' => $dados['CON_sql'],
                    ':javascript' => $dados['CON_javascript'],
                    ':id' => $dados['CON_id']
                )
            );
        }
    }

    public function getConsultas()
    {
        $query = $this->_db->prepare("select * from Consulta_Dashboard");
        $query->execute();
        return $query->fetchall();
    }

    public function getConsulta($id = false)
    {
        if ($id) {


            try {
                $query = $this->_db->prepare("select * from Consulta_Dashboard where CON_id=:id");
                $query->execute(array(':id' => $id));
                $dados = $query->fetchall()[0];

                $sql = preg_replace('/(\'\'.*?\'\'|\".*?\")|\/\*.*?\*\/|--.*?(?=[\r\n]|$)/', '', $dados['CON_sql']);
                if ($sql != '') {
                    // Executa a consulta personalizada que estava gravada no banco
                    $CON_sql = $this->_db->query($sql);
                    $CON_sql->execute();

                    if ($CON_sql->rowCount()) {
                        while ($row = $CON_sql->fetch(PDO::FETCH_ASSOC)) {
                            $arr[] = json_encode($row);
                        }
                        $dados['dados'] = '[' . implode(',', $arr) . ']';
                    }
                }
            } catch (PDOException $e) {
                Sessao::addMsg('erro', addslashes($e->getMessage()));
            }
            return $dados;
        } else {
            return false;
        }
    }
}
