        <!-- =========================================================== -->

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <select class="custom-select form-control-border float-left col-md-3" id="consultas"
                            style="font-weight: 600;">
                            <option value="1">Consulta Padrão</option>
                            <option value="2">Outra consulta</option>
                        </select>
                        <button type="button" id="botao-edit" class="btn btn-default float-left ">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button type="button" id="botao-add" class="btn btn-default float-left ">
                            <i class="fas fa-plus"></i>
                        </button>

                        <button type="button" class="btn btn-default float-right " data-toggle="modal"
                            data-target="#modal-xl">
                            <i class="fas fa-database"></i>
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
        <div class="modal fade" id="modal-xl">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <form method="post" id="consulta">
                        <div class="modal-body">
                            <div class="form-group">
                                <input type="hidden" value="{$consulta.CON_id}" name="CON_id" />

                                <label for="titulo">Titulo da Consulta</label>
                                <input id="titulo" name="CON_titulo" value="{$consulta.CON_titulo}" class="form-control"
                                    type="text" />
                            </div>

                            <div class="form-group clearfix">
                                <div class="custom-control custom-switch custom-switch-on-success float-right">
                                    <input type="checkbox" class="custom-control-input" id="tema" checked>
                                    <label class="custom-control-label" for="tema">Tema Dark</label>
                                </div>
                            </div>

                            <ul class="nav nav-tabs" id="custom-content-below-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="SQL-tab" data-toggle="pill" href="#SQL" role="tab"
                                        aria-controls="SQL" aria-selected="true">SQL</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="JAVASCRIPT-tab" data-toggle="pill" href="#JAVASCRIPT"
                                        role="tab" aria-controls="JAVASCRIPT" aria-selected="false">JAVASCRIPT</a>
                                </li>

                            </ul>
                            <div class="tab-content" id="custom-content-below-tabContent">
                                <div class="tab-pane fade show active" id="SQL" role="tabpanel"
                                    aria-labelledby="SQL-tab">

                                    <div class="form-group">
                                        <div id="editor-sql"></div>
                                        <textarea id="CON_sql" style="display:none;">{$consulta.CON_sql}</textarea>
                                    </div>

                                </div>
                                <div class="tab-pane fade" id="JAVASCRIPT" role="tabpanel"
                                    aria-labelledby="JAVASCRIPT-tab">

                                    <div class="form-group">
                                        <div id="editor-javascript"></div>
                                        <textarea id="CON_javascript"
                                            style="display:none;">{$consulta.CON_javascript}</textarea>
                                    </div>

                                </div>

                            </div>

                        </div>
                        <div class="modal-footer justify-content-between">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
                            <button type="submit" class="btn btn-success">Salvar</button>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>



        <!-- PAGE PLUGINS -->
        <!-- jQuery Mapael -->
        <script type="text/javascript" src="{$_pgParams.path_layout}dist/js/canvasjs.stock.min.js"></script>

        <script src="{$_pgParams.path_layout}plugins/jquery-mousewheel/jquery.mousewheel.js"></script>
        <script src="{$_pgParams.path_layout}plugins/raphael/raphael.min.js"></script>
        <script src="{$_pgParams.path_layout}plugins/jquery-mapael/jquery.mapael.min.js"></script>
        <script src="{$_pgParams.path_layout}plugins/jquery-mapael/maps/usa_states.min.js"></script>
        <!-- ChartJS -->
        <script src="{$_pgParams.path_layout}plugins/chart.js/Chart.min.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="{$_pgParams.path_layout}dist/js/dashboard.js"></script>


        <script type="text/javascript">
            CanvasJS.addCultureInfo("ptbr", {
                decimalSeparator: ".",
                digitGroupSeparator: ",",
                days: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
                resetText: 'Resete',
                savePNGText: 'Salvar PNG',
                saveJPGText: 'Salvar JPG',
                printText: 'Imprimir',
                menuText: 'Mais Opções',
                shortDays: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                months: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto',
                    'Setembro', 'Outubro', 'Novembro', 'Dezembro'
                ],
                shortMonths: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov',
                    'Dez'
                ],
                rangeSelector: {
                    fromText: "De",
                    toText: "A",
                    rangeText: "Periodo"
                }
            });


            $(function() {
                var dados = {$consulta};

                var opcoes = {
                    theme: "light2",
                    exportEnabled: true,
                    title: {
                        text: "Faturamento X Mês"
                    },
                    culture: 'ptbr',
                    charts: [{
                        //height: 100,
                        toolTip: {
                            shared: true
                        },
                        axisX: {
                            labelFormatter: function(e) {
                                return CanvasJS.formatDate(e.value, "DD MMM");
                            },
                            labelAngle: -20
                        },
                        axisY: {
                            prefix: "R$ ",
                            tickLength: 0,
                            labelFormatter: addSymbols,
                        },
                        legend: {
                            verticalAlign: "top"
                        },
                        data: [{
                            showInLegend: true,
                            yValueFormatString: "R$ #,###.##",
                            dataPoints: dados, // Dados são obtidos diretamente da consulta em forma de JSON
                            valueFormatString: "DD-MMM"
                        }]
                    }],
                    rangeSelector: {
                        selectedRangeButtonIndex: 0,
                        inputFields: {
                            //startValue: 4000,
                            //endValue: 6000,
                            valueFormatString: "DD-MMM-YYYY"
                        },
                        buttons: [{
                            label: "1M",
                            range: 1,
                            rangeType: "month"
                        }, {
                            label: "3M",
                            range: 3,
                            rangeType: "month"
                        }, {
                            label: "6M",
                            range: 6,
                            rangeType: "month"
                        }, {
                            label: "1A",
                            range: 1,
                            rangeType: "year"
                        }, {
                            label: "Tudo",
                            range: null,
                            rangeType: "all"
                        }],
                        buttonStyle: {
                            backgroundColorOnHover: "#6b5b95",
                            backgroundColorOnSelect: "#6b5b95"
                        }
                    }
                }
                /**
                 *    Vc pode pegar a variável dados que virá com a informação do banco e tratar 
                 * através do FOR abaixo, onde vc trás o JSON e trata ele como data ou como número
                 */
                var dataPoints = []; // variavel a ser usada com os dados tratados

                if (dataPoints.length > 0) {
                    /*for (var i = 0; i < data.length; i++) {
                        dataPoints.push({
                            x: new Date(data[i].date),
                            y: Number(data[i].open)
                        });
                    }*/
                }
                // Essa função chama o gráfico e passa as opções
                $("#grafico").CanvasJSStockChart(opcoes);
                /**
                 * Essa função encurta os valores como por exemplo 1000.000 = 1M
                 */
                function addSymbols(e) {
                    var suffixes = ["", "K", "M", "B"];
                    var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
                    if (order > suffixes.length - 1)
                        order = suffixes.length - 1;
                    var suffix = suffixes[order];
                    return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
                }
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

        <script>
            require(['vs/editor/editor.main'], () => {

                //-------------- EDITOR SQL --------------------//
                var edit_sql = document.getElementById("editor-sql");
                edit_sql.style.minHeight = '400px';
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
                edit_javascript.style.minHeight = '400px';
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
            $(document).ready(function() {
                if ($('#consultas').val() == '') {
                    $('#botao-edit').hide();
                }
                $('#consultas').change(function() {
                    if ($(this).val() == '') {
                        $('#botao-edit').hide();
                    } else {
                        $('#botao-edit').show();
                    }
                });

            });
        </script>
