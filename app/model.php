<?php


class Model
{
    protected $_db;
    protected $_data;


    // constroi conexao
    public function __construct()
    {
        $this->_registro = Registro::getInstancia();
        $this->_db = $this->_registro->_db;
        $this->getLibs('data.class');
        $this->_data = Data::getData();
    }

    public function array_orderby()
    {
        $args = func_get_args();
        $data = array_shift($args);
        foreach ($args as $n => $field) {
            if (is_string($field)) {
                $tmp = array();
                foreach ($data as $key => $row) {
                    $tmp[$key] = $row[$field];
                }
                $args[$n] = $tmp;
            }
        }
        $args[] = &$data;
        call_user_func_array('array_multisort', $args);
        return array_pop($args);
    }

    public function slug($string)
    {
        $a = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ
ßàáâãäåæçÇèéêëìíîïðñòóôõöøùúûýýþÿŔŕ%&$!?()#@:.ºª, ( )';
        $b = 'aaaaaaaceeeeiiiidnoooooouuuuy
bsaaaaaaacceeeeiiiidnoooooouuuyybyRr-es----------- (-)';

        $string = utf8_decode($string);
        $string = strtr($string, utf8_decode($a), $b);
        $string = strtolower($string);
        $string = preg_replace('/[^a-z0-9-\$\.\,]/', '-', $string);
        $string = preg_replace('/-+/', '-', $string);

        return utf8_encode($string);
    }

    // CARREGA AS LIVRARIAS LIBS
    protected function getLibs($libs)
    {
        $pathLibs = RAIZ . 'lbs' . DS . 'classes' . DS . $libs . '.php';

        if (is_readable($pathLibs)) {
            require_once $pathLibs;
        } else {
            throw new Exception('ERRO ao carregar a livraria, LIBS');
        }
    }

    protected function upload($arquivos)
    {
        $this->getLibs('upload'); // Chama a classe upload
        $files = array();
        $files_name = array();


        foreach ($arquivos['files']['name'] as $key => $value) {
            if (!empty($_FILES['files']['name'][$key])) {
                $name  = $_FILES['files']['name'][$key];
                $type  = $_FILES['files']['type'][$key];
                $tmp   = $_FILES['files']['tmp_name'][$key];
                $error = $_FILES['files']['error'][$key];
                $size  = $_FILES['files']['size'][$key];
                $files[] = [
                    'name'     => $name, 'type'     => $type, 'tmp_name' => $tmp, 'error'    => $error, 'size'     => $size
                ];
            }
        }


        foreach ($files as $file) {
            $up = new upload($file, 'pt_BR');
            if ($up->uploaded) {
                $d = new DateTime('NOW');
                $up->file_new_name_body = $this->slug($up->file_src_name_body) . '_' . $d->format('u');

                $up->process(UPLOAD);
                if ($up->processed) {
                    $files_name[] = $up->file_dst_name;
                    $up->clean();
                } else {
                    Sessao::addMsg('erro', $up->error);
                }
            } else {
                Sessao::addMsg('sucesso', 'Arquivos gravados com sucesso!');
            }
        }

        return $files_name;
    }

    /**
     * Função para cortar o texto
     *
     * @param [String] $texto
     * @param int $limite
     * @param bool $quebra
     *
     * @return String
     */
    public function corta_texto($texto = '', $limite = 50, $quebra = false)
    {
        $tamanho = strlen($texto);
        if ($tamanho <= $limite) { //Verifica se o tamanho do texto é menor ou igual ao limite
            $novo_texto = $texto;
        } else { // Se o tamanho do texto for maior que o limite
            if ($quebra == true) { // Verifica a opção de quebrar o texto
                $novo_texto = trim(substr($texto, 0, $limite)) . "...";
            } else { // Se não, corta $texto na última palavra antes do limite
                $ultimo_espaco = strrpos(substr($texto, 0, $limite), " "); // Localiza o útlimo espaço antes de $limite
                $novo_texto = trim(substr($texto, 0, $ultimo_espaco)) . "..."; // Corta o $texto até a posição localizada
            }
        }
        return $novo_texto; // Retorna o valor formatado
    }
}
