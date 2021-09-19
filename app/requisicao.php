<?php

/**
 * Classe que desmembra a url passada para a chamada dos controles e modulos
 * do sistema
 *
 * @author Jonatas
 */
class Requisicao
{
    public $_urlAtual;
    public $_navLinks;
    private $_modulo;
    private $_Controller;
    private $_metodo;
    private $_argumentos;
    private $_modules;

    public function __construct()
    {
        if (isset($_GET['url'])) {
            // Pega a url e ajuda a sanitizar 
            $url = filter_input(INPUT_GET, 'url', FILTER_SANITIZE_URL);
            // Trata possíveis injections deixando apenas algumas pontuações e alfanumericos
            $url = preg_replace('/([^a-z0-9.-_\/]+)/i', '', $url);
            $url = explode('/', $url);
            $this->_navLinks = $url;
            $url = array_filter($url);

            // separa os blocos da url separados por barra
            $this->_urlAtual = implode('/', $url);
            // lista os modulos da pasta modulos para verificação se o modulo passado
            // no url realmente existe dentro da pasta
            foreach (new DirectoryIterator(RAIZ . "modulos") as $Files) {
                if ($Files->isDir() && $Files->isDot()) {
                    continue;
                }
                $this->_modules[] = $Files->getFilename();
            }

            // o último bloco do url é o módulo que queremos chamar
            $this->_modulo = strtolower(array_shift($url));

            if (!$this->_modulo) {
                $this->_modulo = false;
            } else {
                if (count($this->_modules)) {
                    if (!in_array($this->_modulo, $this->_modules)) {
                        $this->_Controller = $this->_modulo;
                        $this->_modulo = false;
                    } else {
                        $this->_Controller = strtolower(array_shift($url));

                        if (!$this->_Controller) {
                            $this->_Controller = 'index';
                        }
                    }
                } else {
                    $this->_Controller = $this->_modulo;
                    $this->_modulo = false;
                }
            }

            $this->_metodo = strtolower(array_shift($url));
            $this->_argumentos = $url;
        }

        if (!$this->_Controller) {
            $this->_Controller = CONTROLE_PATRAO;
        }

        if (!$this->_metodo) {
            $this->_metodo = 'index';
        }

        if (!isset($this->_argumentos)) {
            $this->_argumentos = array();
        }

        /*echo "<pre>";
        print_r($this);
        echo "</pre>";*/
    }

    public function getController()
    {
        return $this->_Controller;
    }

    public function getModulo()
    {
        return $this->_modulo;
    }

    public function getMetodo()
    {
        return $this->_metodo;
    }

    public function getArgs()
    {
        return $this->_argumentos;
    }
}
