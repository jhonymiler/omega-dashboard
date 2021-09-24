        <!-- =========================================================== -->
        <style>
            #header-grafico button {
                margin: 0 5px;
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


                        <button type="button" id="botao-delete" class="float-right btn btn-danger float-left "
                            data-toggle="modal" data-target="#modal-sm"> <i class="fas fa-trash"></i>
                        </button>
                        <button type="button" id="botao-edit" class="float-right btn btn-info float-left ">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button type="button" id="botao-add" class="float-right btn btn-success float-left ">
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
        <div id="janela_modal"></div>

        <div class="modal fade" id="modal-sm">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Excluir Consulta</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Deseja mesmo excluir a consulta:</p>
                        <p><b id='ex-consulta'></b></p>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Não</button>
                        <button type="button" class="btn btn-danger">Sim</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <!-- PAGE PLUGINS -->
        <!-- jQuery Mapael -->
        <script type="text/javascript" src="{$_pgParams.path_layout}dist/js/canvasjs.stock.min.js"></script>
        <script src="{$_pgParams.path_layout}dist/js/canvasjs.min.js"></script>
        <script src="{$_pgParams.path_layout}plugins/jquery-mousewheel/jquery.mousewheel.js"></script>



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
                CanvasJS.addCultureInfo("ptbr", opcoes);


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
            function loadEditor() {
                require(['vs/editor/editor.main'], () => {

                    //-------------- EDITOR SQL --------------------//
                    var edit_sql = document.getElementById("editor-sql");
                    edit_sql.style.minHeight = '480px';
                    edit_sql.style.height = '100%';
                    edit_sql.style.width = '100%';

                    var codigo_sql = $('#CON_sql').val() == '' ? "\n-- Escreva seu código aqui :)" : $(
                        '#CON_sql').val();

                    const editor_sql = monaco.editor;
                    var sql = editor_sql.create(edit_sql, {
                        theme: 'vs-dark',
                        model: editor_sql.createModel(codigo_sql, "sql"),
                        minimap: {
                            enabled: true
                        },
                        scrollbar: {
                            vertical: 'auto'
                        },
                        language: "sql",
                        wordWrap: 'wordWrapColumn',
                        //wordWrapColumn: 40,
                        // Set this to false to not auto word wrap minified files
                        wordWrapMinified: true,
                        // try "same", "indent" or "none"
                        wrappingIndent: "indent",
                        autoIndent: true,
                        automaticLayout: true
                    });

                    //--------------------- EDITOR JAVASCRIPT ----------------------------/
                    var edit_javascript = document.getElementById("editor-javascript");
                    edit_javascript.style.minHeight = '480px';
                    edit_javascript.style.height = '100%';
                    edit_javascript.style.width = '100%';

                    var CON_javascript = $('#CON_javascript').val() == '' ?
                        "\n // Escreva seu código aqui :)" : $(
                            '#CON_javascript').val();

                    const editor_javascript = monaco.editor;

                    var javascript = editor_javascript.create(edit_javascript, {
                        theme: 'vs-dark',
                        model: editor_javascript.createModel(CON_javascript, "javascript"),
                        minimap: {
                            enabled: true
                        },
                        scrollbar: {
                            vertical: 'auto'
                        },
                        language: "javascript",
                        wordWrap: 'wordWrapColumn',
                        //wordWrapColumn: 40,
                        wordWrapMinified: true,
                        wrappingIndent: "indent",
                        autoIndent: true,
                        automaticLayout: true
                    });

                    $("#tema").change(function() {

                        var newTheme = $(this).is(":checked") ? 'vs-dark' : 'vs';
                        monaco.editor.setTheme(newTheme);
                    });

                    const form = document.getElementById("consulta");
                    form.addEventListener("formdata", e => {
                        e.formData.append('CON_sql', sql.getModel().getValue());
                        e.formData.append('CON_javascript', javascript.getModel().getValue());
                    });


                });
            }


            $(document).ready(function() {

                loadEditor();

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

                $("#botao-delete").click(function() {

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




            });
        </script>
