<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{$titulo|default:"Aro Dashboard"}</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/fontawesome-free/css/all.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
        <!-- Toastr -->
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/toastr/toastr.min.css">
        <link rel="stylesheet" href="{$_pgParams.path_layout}dist/css/adminlte.css">

        <!-- FAVICON -->
        <link rel="apple-touch-icon" sizes="180x180" href="{$_pgParams.path_layout}dist/img/aro-logo.png">
        <link rel="icon" type="image/png" sizes="32x32" href="{$_pgParams.path_layout}dist/img/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="{$_pgParams.path_layout}dist/img/favicon-16x16.png">
        <link rel="manifest" href="{$_pgParams.path_layout}dist/img/site.webmanifest">
        <!-- DataTables -->
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet"
            href="{$_pgParams.path_layout}plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
        <link rel="stylesheet" href="{$_pgParams.path_layout}plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
        <!-- ./wrapper -->
        <link href="{$_pgParams.path_layout}dist/css/jquery.dm-uploader.min.css" rel="stylesheet">
        <link rel="stylesheet" href="{$_pgParams.path_layout}dist/css/custom.css">
        <link rel="stylesheet" href="{$_pgParams.path_layout}dist/css/cropper.css">

        <!-- REQUIRED SCRIPTS -->
        <!-- jQuery -->
        <script src="{$_pgParams.path_layout}plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap -->
        <script src="{$_pgParams.path_layout}plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- overlayScrollbars -->
        <script src="{$_pgParams.path_layout}plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <!-- AdminLTE App -->
        <script src="{$_pgParams.path_layout}dist/js/jquery.validate.min.js"></script>
        <script src="{$_pgParams.path_layout}dist/js/jquery.validation.pt-br.js"></script>
        <script src="{$_pgParams.path_layout}plugins/inputmask/jquery.inputmask.min.js"></script>

        <script src="{$_pgParams.path_layout}dist/js/adminlte.min.js"></script>





    </head>

    <body class="layout-top-nav">
        <div class="wrapper">

            {assign var="imagem" value="{$_pgParams.path_layout}dist/img/avatar.png"}


            <!-- Preloader -->
            <div class="preloader flex-column justify-content-center align-items-center">
                <img class="animation__wobble" src="{$_pgParams.path_layout}dist/img/aro-logo.png" alt="ARO ERP"
                    height="60" width="60">
            </div>

            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-dark">
                <div class="container">
                    <a href="{$_pgParams.RAIZ}/painel" class="navbar-brand">
                        <img src="{$_pgParams.path_layout}dist/img/aro-logo-192x192.png" alt="ARO ERP"
                            class="brand-image" style="opacity: .8">
                        <span class="brand-text font-weight-light">ARO ERP - Dashboard</span>
                    </a>

                    <button class="navbar-toggler order-1" type="button" data-toggle="collapse"
                        data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>


                    <!-- Right navbar links -->
                    <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">

                        <!-- Notifications Dropdown Menu -->
                        <li class="nav-item dropdown">
                            <a class="nav-link" data-toggle="dropdown" href="#">
                                <i class="fas fa-user-edit"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-md dropdown-menu-right">
                                <a href="#" class="dropdown-item" data-toggle="modal" data-target="#modal-senha">
                                    <i class="fas fa-key"></i> &ensp; &ensp; &ensp; Alterar Minha Senha
                                </a>

                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{$_pgParams.RAIZ}login/sair" role="button">
                                <i class="fas fa-sign-out-alt"></i>
                            </a>
                        </li>
                    </ul>
                </div>

            </nav>
            <!-- /.navbar -->




            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h3 class="m-0">Gráficos Personalizados</h3>
                            </div>
                        </div><!-- /.row -->
                    </div><!-- /.container -->
                </div>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                    <div class="container">
                        <!-- Conteudos da página -->

                        {if is_array($_conteudo)}
                            {foreach from=$_conteudo item=conteudo}
                                {include file=$conteudo}
                            {/foreach}
                        {else}
                            {include file="{$_pgParams.RAIZ}modulos/painel/views/index.tpl"}
                        {/if}
                        <!-- /.conteudos -->
                    </div>
                    <!--/. container -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <div class="modal fade" id="modal-senha">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Alterar Minha Senha</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form id="altera_senha" method="post" action="{$_pgParams.RAIZ}login/senha">
                            <div class="modal-body">

                                <div class="card-body">
                                    <div class="form-group">
                                        <input type="password" name="senha_atual" class="form-control" id="senha_atual"
                                            placeholder="Senha Atual">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="senha" class="form-control" id="senha"
                                            placeholder="Nova Senha">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="confirma" class="form-control" id="confirma"
                                            placeholder="Confirme a Senha">
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer justify-content-between">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                                <button type="submit" class="btn btn-success">Salvar</button>
                            </div>
                        </form>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>


        </div>
        <textarea id="campos" style="display: none;">{$campos}</textarea>
        <script type="text/javascript">
            $(document).ready(function() {
                {if isset($msg) && is_array($msg)}
                    {foreach item=m from=$msg}
                        $(document).Toasts('create', {
                            toast: true,
                            delay: 5000,
                            class: '{$m.tipo}',
                            position: 'topRight',
                            autohide: true,
                            body: '{$m.msg}'
                        });
                    {/foreach}
                {/if}
            });
            {if !empty($campos)}
                $(document).ready(function() {
                    var campos = JSON.parse($("#campos").val());
                    preencher(campos);
                });

                function preencher(json) {
                    for (var key in json) {
                        $("[name=" + key + "]").val(json[key]);
                    }
                };
            {/if}


            $(function() {

                $('#altera_senha').validate({
                    rules: {
                        senha_atual: {
                            required: true,
                            maxlength: 10,
                        },
                        senha: {
                            required: true,
                            maxlength: 10,
                        },
                        confirma: {
                            required: true,
                            maxlength: 10,
                            equalTo: "#senha"
                        }
                    },
                    messages: {
                        senha_atual: {
                            required: "Por favor preencha sua senha atual",
                            maxlength: "No máximo 10 caracteres"
                        },
                        senha: {
                            required: "Digite a nova senha",
                            maxlength: "No máximo 10 caracteres"
                        },
                        confirma: {
                            required: "Digite a confirmação da nova senha",
                            maxlength: "No máximo 10 caracteres",
                            equalTo: "As não são iguais."
                        },
                    },
                    errorElement: 'span',
                    errorPlacement: function(error, element) {
                        error.addClass('invalid-feedback');
                        element.closest('.form-group').append(error);
                    },
                    highlight: function(element, errorClass, validClass) {
                        $(element).addClass('is-invalid');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).removeClass('is-invalid');
                    }
                });
            });
        </script>
    </body>


</html>
