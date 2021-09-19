<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal-xl">
    Criar Consulta
</button>

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


    require(['vs/editor/editor.main'], () => {
        // Initialize the editor
        const editor = monaco.editor.create(edit, {
            theme: 'vs-dark',
            model: monaco.editor.createModel({"$('#codigo').val()"|default:"-- Escreva seu código aqui :)"}, "sql"),
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
