<?php
/*******************************
    $data = new Data('2012-11-29');

    ou

    se quizer obter a data atual basta chamar a classe da segunte maneira:
    $data = new Data;
    print_r($data);

    ou

    Data::getData('2012-11-29');

    ou

    Data::getData();

*******************************/
class Data
{
    public $data;
    public $dia;
    public $mes;
    public $ano;
    public $semana;
    public $nomediadasemana;
    public $nomedomes;
    public $por_extenso;
    public $por_extenso_curta;
    
    private $meses = array(
            1 => "Janeiro",
            2 => "Fevereiro",
            3 => "Março",
            4 => "Abril",
            5 => "Maio",
            6 => "Junho",
            7 => "Julho",
            8 => "Agosto",
            9 => "Setembro",
            10 => "Outubro",
            11 => "Novembro",
            12 => "Dezembro"
    );
        
    private $diasdasemana = array(
            1 => "Segunda-Feira",
            2 => "Terça-Feira",
            3 => "Quarta-Feira",
            4 => "Quinta-Feira",
            5 => "Sexta-Feira",
            6 => "Sabado",
            0 => "Domingo"
    );
    
    public function __construct($data = false)
    {
        if ($data != false) {
            $this->dia 				= date('d', strtotime($data));
            $this->mes 				= intval(date('m', strtotime($data)));
            $this->ano 				= date('Y', strtotime($data));
            $this->semana  			= intval(date('w', strtotime($data)));
        } else {
            $data = getdate();
            $this->dia 				= $data["mday"];
            $this->mes 				= intval($data["mon"]);
            $this->ano 				= $data["year"];
            $this->semana  			= intval($data["wday"]);
        }
        
        $this->data 	    		= $this->dia.'/'.$this->mes.'/'.$this->ano;
        $this->nomediadasemana 	    = $this->diasdasemana[$this->semana];
        $this->nomedomes 			= $this->meses[$this->mes];
        $this->por_extenso			= $this->nomediadasemana.', '.$this->dia.' de '.$this->nomedomes.' de '.$this->ano;
        $this->por_extenso_curta	= substr($this->nomediadasemana, 0, 3).', '.$this->dia.'/'.substr($this->nomedomes, 0, 3).'/'.$this->ano;
    }
    
    public static function getData($data = false)
    {
        $encoder = new self($data);
        return $encoder;
    }
}
