<?php

require_once RAIZ . 'lbs' . DS . 'smarty' . DS . 'Smarty.class.php';

class View extends Smarty
{
    private $_request;
    private $_js;
    private $_paths;
    private $_jsPlugin;
    private $_template;
    private $_itemMenu;
    public $_pgParams;
    private $_navLinks;
    private $_conteudo = array();
    public $_msg = array();



    public function __construct(Requisicao $peticion)
    {
        parent::__construct();
        $this->_request   = $peticion;
        $this->_js        = array();
        $this->_paths     = array();
        $this->_jsPlugin  = array();
        $this->_itemMenu  = '';
        // determina o cache
        $this->caching = false;

        $this->setTemplate(DEFAOULT_LAYOUT);
    }

    public function getPath($chave)
    {
        return $this->_paths[$chave];
    }

    public function setTemplate($temp)
    {
        // DETERMINA OS CAMINHOS DO LAYOUT
        // seta as configurações do SMARTY
        $this->_template  = $temp;

        $this->_paths['template'] = RAIZ . 'views' . DS .  $this->_template . DS;
        $this->template_dir = $this->_paths['template'];
        $this->config_dir   = RAIZ . 'views' . DS .  $this->_template . DS . 'configs' . DS;
        $this->cache_dir    = RAIZ . 'tmp' . DS . 'cache' . DS;
        $this->compile_dir  = RAIZ . 'tmp' . DS . 'template' . DS;
        $this->debugging = false;
        if ($this->_request->getModulo()) {
            $this->_paths['view'] = RAIZ . 'modulos' . DS . $this->_request->getModulo() . DS . 'views' . DS;
        } else {
            $this->_paths['view'] = $this->_paths['template'];
        }
        $this->_paths['js']   = BASE_URL . 'views' . DS . 'layout' . DS . $this->_template . DS;

        $this->_pgParams = array(
            'path_layout'  => BASE_URL . 'views/' . DEFAOULT_LAYOUT . '/',
            'path_css'     => BASE_URL . 'views/' . DEFAOULT_LAYOUT . '/css/',
            'path_img'     => BASE_URL . 'views/' . DEFAOULT_LAYOUT . '/images/',
            'path_js'      => BASE_URL . 'views/' . DEFAOULT_LAYOUT . '/js/',
            'js'           => $this->_js,
            'js_plugin'    => $this->_jsPlugin,
            'RAIZ'         => BASE_URL,
            'REAL_PATH'    => RAIZ,
            'urlAtual'     => $this->_request->_urlAtual,
            'configs'      => array(
                'app_nome'    => APP_NOME,
                'app_slogan'  => APP_SLOGAN,
                'app_company' => APP_COMPANIA,
                'app_path'    => APP_PATH
            )
        );

        $this->assign('_pgParams', $this->_pgParams);
    }


    public function addNavLink($url, $nome)
    {
        $this->_navLinks[] = array('url' => $url, 'nome' => $nome);
    }

    public function addConteudo()
    {
        $args = func_get_args();

        if (func_num_args() == 1) {
            $template = $this->_paths['view'] . $args[0] . '.tpl';
        }
        if (func_num_args() >= 2) {
            $template = RAIZ . 'modulos' . DS . $this->_request->getModulo() . DS . 'views' . DS . $args[0] . DS . $args[1] . '.tpl';
        }
        // verifica se o caminh é válido
        if (!is_readable($template)) {
            $temp = $this->_paths['template'] . 'index.tpl';
        } else {
            $temp =  $template;
        }

        $this->_conteudo[] = $temp;
    }

    public function renderizar()
    {
        $this->assign('navLinks', $this->_navLinks);
        $this->assign('_conteudo', $this->_conteudo);

        $this->assign('msg', Sessao::getMsg($limpa = true));

        $this->display($this->_paths['template'] . 'index.tpl');
    }

    public function addJs($js)
    {
        if (is_array($js)) {
            foreach ($js as $k => $script) {
                $this->_js[] = $script;
            }
        } elseif (is_string($js)) {
            $this->_js[] = $js;
        } else {
            throw new Exception('Erro ao carregar o Js: ');
        }
    }

    public function getJs()
    {
        return $this->_js;
    }

    public function addCss($css)
    {
        if (is_array($css)) {
            foreach ($css as $k => $script) {
                array_push($this->_css, BASE_URL . 'views/' . $this->_Controller . '/css/' . $script . '.css');
            }
        } elseif (is_string($css)) {
            array_push($this->_css, BASE_URL . 'views/' . $this->_Controller . '/css/' . $css . '.css');
        } else {
            throw new Exception('Erro ao carregar o CSS: ');
        }
    }
}
