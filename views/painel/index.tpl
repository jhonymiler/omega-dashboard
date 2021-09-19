<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{$sessaoUsuario.nome|default:"usuário"} - {$titulo|default:""}</title>

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

    <body class="sidebar-collapse control-sidebar-slide-open sidebar-mini-md">
        <div class="wrapper">

            {assign var="imagem" value="{$_pgParams.path_layout}dist/img/avatar.png"}


            <!-- Preloader -->
            <div class="preloader flex-column justify-content-center align-items-center">
                <img class="animation__wobble" src="{$_pgParams.path_layout}dist/img/aro-logo.png" alt="ARO HELPDESK"
                    height="60" width="60">
            </div>

            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-dark">
                <!-- Left navbar links -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i
                                class="fas fa-bars"></i></a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="{$_pgParams.RAIZ}" class="nav-link">Home</a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="#" class="nav-link">Configurações</a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a href="{$_pgParams.RAIZ}login/sair" class="nav-link">Sair</a>
                    </li>
                </ul>

                <!-- Right navbar links -->
                <ul class="navbar-nav ml-auto">

                    <li class="nav-item">
                        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.navbar -->


            <!-- Main Sidebar Container -->
            {include file='sidebar.tpl'}

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">{$titulo}</h1>
                            </div><!-- /.col -->
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    {assign var=counter value=count($navLinks)}
                                    {foreach from=$navLinks item="link" name=i}

                                        {if $smarty.foreach.i.iteration == $counter}
                                            <li class="breadcrumb-item active">{$link.nome}</li>
                                        {else}
                                            <li class="breadcrumb-item"><a href="{$_pgParams.RAIZ}{$link.url}">{$link.nome}</a>
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ol>
                            </div><!-- /.col -->
                        </div><!-- /.row -->
                    </div><!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
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
                    <!--/. container-fluid -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->


            <!-- Main Footer -->
            <footer class="main-footer">
                <strong>Copyright &copy; 2021 <a href="https://arocontabilidade.com.br/" target="_blank">Grupo Aro
                        Contabilidade</a>.</strong>
                Direitos reservados.
                <div class="float-right d-none d-sm-inline-block">
                    <b>Version</b> 1.0.0
                </div>
            </footer>
        </div>
        <textarea id="campos" style="display: none;">{$campos}</textarea>
        <script type="text/javascript">
            $(document).ready(function() {
                {if is_array($msg)}
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
                $(".nav-link").removeClass('active');
                $("[data-link={$current_link}]").addClass('active')
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
        </script>

    </body>

</html>
