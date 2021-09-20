<div class="modal fade" id="modal-xl">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <form method="post" id="consulta">
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" value="{$consulta_personalizada.CON_id}" name="CON_id" />

                        <label for="titulo">Titulo da Consulta</label>
                        <input id="titulo" name="CON_titulo" value="{$consulta_personalizada.CON_titulo}"
                            class="form-control" type="text" />
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
                            <a class="nav-link" id="JAVASCRIPT-tab" data-toggle="pill" href="#JAVASCRIPT" role="tab"
                                aria-controls="JAVASCRIPT" aria-selected="false">JAVASCRIPT</a>
                        </li>

                    </ul>
                    <div class="tab-content" id="custom-content-below-tabContent">
                        <div class="tab-pane fade show active" id="SQL" role="tabpanel" aria-labelledby="SQL-tab">

                            <div class="form-group">
                                <div id="editor-sql"></div>
                                <textarea id="CON_sql"
                                    style="display:none;">{$consulta_personalizada.CON_sql}</textarea>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="JAVASCRIPT" role="tabpanel" aria-labelledby="JAVASCRIPT-tab">

                            <div class="form-group">
                                <div id="editor-javascript"></div>
                                <textarea id="CON_javascript"
                                    style="display:none;">{$consulta_personalizada.CON_javascript}</textarea>
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
