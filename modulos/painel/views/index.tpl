        <!-- =========================================================== -->
        <style>
            #header-grafico button {
                margin: 0 5px;
            }

            .monaco-editor {
                padding-top: 10px;
            }
        </style>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div id="header-grafico" class="card-header">
                        <select class="form-control float-left col-md-4" id="consultas" style="font-weight: 600;">
                            <option value="">Escolha uma Consulta</option>
                            {if is_array($consultas)}
                                {foreach from=$consultas item="con"}
                                    <option value="{$con.CON_id}">{$con.CON_titulo}</option>
                                {/foreach}
                            {/if}
                        </select>
                        <button type="button" id="permissao" class="btn btn-secondary float-left ">
                            <i class="fas fa-user-shield"></i>
                        </button>
                        <button type="button" class="float-right btn btn-danger" data-toggle="modal"
                            data-target="#modal-sm"> <i class="fas fa-trash"></i>
                        </button>
                        <button type="button" id="botao-edit" class="float-right btn btn-info">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button type="button" id="botao-add" class="float-right btn btn-success">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="chart">
                                    <!-- Sales Chart Canvas -->
                                    <div id="grafico" style="min-height: 400px;width:100%"></div>
                                </div>
                                <!-- /.chart-responsive -->
                            </div>

                        </div>
                        <!-- /.row -->
                    </div>

                </div>
                <!-- /.card -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->

        <div class="modal fade" id="permissao-modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Permissões de Usuários</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="permissao-body">
                        <nav class="navbar navbar-default" role="navigation">
                            <div class="container-fluid">
                                <form class="navbar-form navbar-left" role="search">
                                    <div class="form-group">
                                        <select class="select" multiple data-mdb-filter="true">
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                            <option value="4">Four</option>
                                            <option value="5">Five</option>
                                            <option value="6">Six</option>
                                            <option value="7">Seven</option>
                                            <option value="8">Eight</option>
                                            <option value="9">Nine</option>
                                            <option value="10">Ten</option>
                                        </select>
                                    </div>

                                </form>

                            </div>
                            <!-- .container-fluid -->
                        </nav>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        <button type="button" class="btn btn-primary">Salvar</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div id="janela_modal"></div>

        <div class="modal fade" id="modal-sm">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            {if isset($consulta_personalizada.CON_titulo)}{$consulta_personalizada.CON_titulo}{/if}</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h5 style="text-align: center;">Deseja mesmo excluir a consulta?</h5>

                        <p><b id='ex-consulta'></b></p>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button id="botao-delete" type="button" class="btn btn-danger">Sim</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Não</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <!-- PAGE PLUGINS -->
        <!-- jQuery Mapael -->
        <script src="{$_pgParams.path_layout}dist/js/bootstrap-select.min.js" defer></script>

        <script type="text/javascript" src="{$_pgParams.path_layout}dist/js/canvasjs.stock.min.js"></script>
        <script src="{$_pgParams.path_layout}dist/js/canvasjs.min.js"></script>





        <script type="text/javascript">
            $(function() {

                var opcoes = {
                    decimalSeparator: ",",
                    digitGroupSeparator: ".",
                    days: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
                    resetText: 'Resete',
                    savePNGText: 'Salvar PNG',
                    saveJPGText: 'Salvar JPG',
                    printText: 'Imprimir',
                    menuText: 'Mais Opções',
                    shortDays: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                    months: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho',
                        'Agosto',
                        'Setembro', 'Outubro', 'Novembro', 'Dezembro'
                    ],
                    shortMonths: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out',
                        'Nov',
                        'Dez'
                    ],
                    rangeSelector: {
                        fromText: "De",
                        toText: "A",
                        rangeText: "Periodo"
                    }
                };


                var d = [{
                    x: new Date('19/09/2021'),
                    y: Number(25)
                }];
                var dados = []; // variavel a ser usada com os dados tratados

                var consulta_personalizada = {if isset($consulta_personalizada.dados)}{$consulta_personalizada.dados}{else}d{/if};

                {if isset($consulta_personalizada.CON_javascript)}
                    {$consulta_personalizada.CON_javascript}
                {/if}

            });
        </script>


        <script>
            var require = {
                paths: {
                    'vs': '{$_pgParams.path_layout}plugins/vs',
                }
            };
        </script>
        <script src="{$_pgParams.path_layout}plugins/vs/loader.js"></script>
        <script src="{$_pgParams.path_layout}plugins/toastr/toastr.min.js"></script>

        <script>
            $(document).ready(function() {







                    {if isset($consulta_personalizada.CON_id)}    
                        $('#consultas').val("{$consulta_personalizada.CON_id}");




                    {/if}

                    if ($('#consultas').val() == '') {
                        $('#botao-edit').hide();
                    } else {
                        $('#botao-edit').show();
                    }

                    $('#consultas').change(function() {
                        if ($(this).val() == '') {
                            $('#botao-edit').hide();
                        } else {
                            window.location.href = "{$_pgParams.RAIZ}painel/dashboard/index/" + $('#consultas').val();
                        }
                    });

                    $("#permissao").click(function() {
                        $('#permissao-modal').modal('show');
                    });

                    $("#botao-delete").click(function() {
                        c = $('#consultas').val()
                        window.location.href = "{$_pgParams.RAIZ}painel/dashboard/excluir/" + c;
                    });

                    $("#botao-edit").click(function() {
                            c = $('#consultas').val()
                            $.get("{$_pgParams.RAIZ}painel/dashboard/editor/"+c,
                            function(data) {
                                $("#janela_modal").html(data);
                                loadEditor();
                                $("#modal-xl").modal({
                                    show: true
                                });
                            });
                    });

                $("#botao-add").click(function() {
                        $.get("{$_pgParams.RAIZ}painel/dashboard/editor/", 
                        function(data) {
                            $("#janela_modal").html(data);
                            loadEditor();
                            $("#modal-xl").modal({
                                show: true
                            });
                        });
                });


            setInterval(function() {
                $.get("{$_pgParams.RAIZ}login/timeout", 
                function(data) {
                    $('body').html(data);
                });
            }, {$time}*1000);


            });
        </script>
