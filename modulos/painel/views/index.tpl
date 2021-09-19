        <!-- =========================================================== -->

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <select class="custom-select form-control-border float-left col-md-3" id="consultas"
                            style="font-weight: 600;">
                            <option>Faturamento x Periodo</option>
                            <option>Value 2</option>
                            <option>Value 3</option>
                        </select>
                        <button type="button" class="btn btn-default float-left ">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button type="button" class="btn btn-default float-left ">
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
                                <p class="text-center">
                                    <strong>Relatório do dia: 1 Jan, 2021 - 30 Jul, 2021</strong>
                                </p>

                                <div class="chart">
                                    <!-- Sales Chart Canvas -->
                                    <div id="grafico" style="min-height: 400px;width:100%"></div>
                                </div>
                                <!-- /.chart-responsive -->
                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- ./card-body -->
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-sm-3 col-6">
                                <div class="description-block border-right">
                                    <span class="description-percentage text-success"><i class="fas fa-caret-up"></i>
                                        17%</span>
                                    <h5 class="description-header">$35,210.43</h5>
                                    <span class="description-text">TOTAL REVENUE</span>
                                </div>
                                <!-- /.description-block -->
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-3 col-6">
                                <div class="description-block border-right">
                                    <span class="description-percentage text-warning"><i class="fas fa-caret-left"></i>
                                        0%</span>
                                    <h5 class="description-header">$10,390.90</h5>
                                    <span class="description-text">TOTAL COST</span>
                                </div>
                                <!-- /.description-block -->
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-3 col-6">
                                <div class="description-block border-right">
                                    <span class="description-percentage text-success"><i class="fas fa-caret-up"></i>
                                        20%</span>
                                    <h5 class="description-header">$24,813.53</h5>
                                    <span class="description-text">TOTAL PROFIT</span>
                                </div>
                                <!-- /.description-block -->
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-3 col-6">
                                <div class="description-block">
                                    <span class="description-percentage text-danger"><i class="fas fa-caret-down"></i>
                                        18%</span>
                                    <h5 class="description-header">1200</h5>
                                    <span class="description-text">GOAL COMPLETIONS</span>
                                </div>
                                <!-- /.description-block -->
                            </div>
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.card-footer -->
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
                                <label for="titulo">Titulo da Consulta</label>
                                <input id="titulo" name="titulo" class="form-control" type="text" />
                            </div>
                            <div class="form-group clearfix">
                                <div class="custom-control custom-switch custom-switch-on-success float-right">
                                    <input type="checkbox" class="custom-control-input" id="tema" checked>
                                    <label class="custom-control-label" for="tema">Tema Dark</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <div id="editor-codigo"></div>
                                <textarea id="codigo" style="display:none;">{$codigo}</textarea>
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

        <script>
            var require = {
                paths: {
                    'vs': '{$_pgParams.path_layout}plugins/vs',
                }
            };
        </script>
        <script src="{$_pgParams.path_layout}plugins/vs/loader.js"></script>
        <script>
            var edit = document.getElementById("editor-codigo");
            edit.style.minHeight = '400px';
            //edit.style.maxHeight = '100vh';
            edit.style.height = '100%';
            edit.style.width = '100%';
            //edit.style.resize = 'vertical';
            //edit.style.overflow = 'auto';

            var codigo = $('#codigo').val() == '' ? "\n-- Escreva seu código aqui :)" : $('#codigo').val();

            require(['vs/editor/editor.main'], () => {
                // Initialize the editor
                const editor = monaco.editor.create(edit, {
                    theme: 'vs-dark',
                    model: monaco.editor.createModel(codigo, "sql"),
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

                /*$("#consulta").submit(function() {
                    alert(editor.getModel().getValue());
                    return false;
                });*/
                const form = document.getElementById("consulta");
                form.addEventListener("formdata", e => {
                    e.formData.append('codigo', editor.getModel().getValue());
                });

                $("#tema").change(function() {

                    var newTheme = $(this).is(":checked") ? 'vs-dark' : 'vs';
                    monaco.editor.setTheme(newTheme);
                });


            });
        </script>

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
                var dataPoints1 = [],
                    dataPoints2 = [],
                    dataPoints3 = [];
                var stockChartOptions = {
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
                            //name: "A Pagar",
                            yValueFormatString: "R$ #,###.##",
                            dataPoints: dataPoints2,
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
                {literal}
                    $.getJSON("https://canvasjs.com/data/docs/ltceur2018.json", function(data) {
                        for (var i = 0; i < data.length; i++) {
                            dataPoints1.push({x: new Date(data[i].date), y: [Number(data[i].open), Number(data[i].high), Number(data[i].low), Number(data[i].close)]});;
                            dataPoints2.push({x: new Date(data[i].date), y: Number(data[i].volume_eur)});
                            dataPoints3.push({x: new Date(data[i].date), y: Number(data[i].close)});
                        }
                        $("#grafico").CanvasJSStockChart(stockChartOptions);
                    });
                {/literal}
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
