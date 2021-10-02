<?php

/**
 * Classe para capturar informações dos arquivos INFS
 * e fazer login no sistema omega pelo Sql Server
 * Possui funções utilitárias para tratamento das informações
 * e a validação do login propriamente dito
 */
class LoginModel extends Model
{

    public $path = URL_INFS;
    public $dados;

    /**
     * Undocumented function
     *
     * @param [type] $path
     */
    public function __construct()
    {

        if (is_readable($this->path)) {
            $caminhoReal = realpath($this->path);

            $infs = array();
            foreach (new DirectoryIterator($caminhoReal) as $Files) {
                if ($Files->isDir() && $Files->isDot()) continue;

                if (substr($Files->getFilename(), -3) == 'INF') {
                    $INF =  realpath($Files->getPath() . DS . $Files->getFilename());
                    $arquivos =  file($INF, FILE_IGNORE_NEW_LINES);
                    foreach ($arquivos as $arquivo) {
                        $string = preg_replace('/[^a-z0-9A-Z_\/\\\-]+/', '|', $arquivo);
                        $string = preg_replace('/\|+/', '|', $string);
                        $string = preg_replace('/\|[a-zA-Z0-9{1}]\|/', '|', $string);
                        $string = preg_replace('/\|[a-zA-Z0-9{1}]\|/', '|', $string);
                        $string = preg_replace('/\|[\\\]\|/', '|', $string);
                        $string = preg_replace('/\|1000\|/', '|', $string);
                        $string = strval($string);
                        /**
                         * [1] = Inf
                         * [3] = Banco
                         * [2] = instância
                         * [4] = Usuário
                         * [5] = Senha
                         * [6] = HD
                         * [7] = PC
                         */
                        $camposInf = explode('|', $string);

                        $this->dados[] = array(
                            'inf' => strtoupper($camposInf[1]),
                            'instancia' => $camposInf[2],
                            'banco' => $camposInf[3],
                            'usuario' => $camposInf[4],
                            'senha' => $this->senhaDecrypt($camposInf[5]),
                            'hd' => $camposInf[6],
                            'pc' => $camposInf[7]
                        );
                    }
                }
            }
            if (is_array($this->dados) && count($this->dados) > 0) {
                return $this->dados;
            } else {
                return false;
            }
        }
    }


    /**
     * Função para decriptar senha do Omega
     *
     * @param [String] $str
     *
     * @return String
     */
    public function senhaDecrypt($str = '')
    {
        $chr = '';
        foreach (str_split($str) as $s) {
            $chr .= chr(ord($s) - 7);
        }
        return "$chr";
    }
    /**
     * Função para Encriptar senha do Omega
     *
     * @param [String] $str
     *
     * @return String
     */
    public function senhaEncrypt($str = '')
    {
        $chr = '';
        foreach (str_split(strtoupper($str)) as $s) {
            $chr .= chr(ord($s) + 7);
        }
        return $chr;
    }
}
