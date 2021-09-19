<?php


// bootstrap
class Ferramentas
{
    /**
     *  PROCESSA A NOVA REQUISIÇÃO
     *
     * requisição qualquer passada para processamento
     * @param request $peticion
     */
    public static function rodar(Requisicao $peticion)
    {

        $modulo = $peticion->getModulo();
        $controller = $peticion->getController() . 'Controller';
        $metodo = $peticion->getMetodo();
        $args = $peticion->getArgs();

        if ($modulo) {
            $rutaModulo = RAIZ . 'controllers' . DS . $modulo . 'Controller.php';

            if (is_readable($rutaModulo)) {
                require_once $rutaModulo;
                $rutaController = RAIZ . 'modulos' . DS . $modulo . DS . 'controllers' . DS . $controller . '.php';
            } else {
                throw new Exception('Error de base de modulo');
            }
        } else {
            $rutaController = RAIZ . 'controllers' . DS . $controller . '.php';
        }
        //echo $rutaController;
        if (is_readable($rutaController)) {
            require_once $rutaController;
            $controller = new $controller;

            if (is_callable(array($controller, $metodo))) {
                $metodo = $peticion->getMetodo();
            } else {
                $metodo = 'index';
            }

            if (isset($args)) {
                call_user_func_array(array($controller, $metodo), $args);
            } else {
                call_user_func(array($controller, $metodo));
            }
        } else {
            require_once RAIZ . 'controllers' . DS . 'erroController.php';
            $controller = new erroController;
            call_user_func(array($controller, "index"));
        }
    }
}
