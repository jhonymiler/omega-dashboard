$( function () {


    var room = $( "#chat-mensagem" ).attr( 'sala' );
    var conn;
    var conn_status = false;


    window.onload = function () {
        if ( conn_status ) {
            conn.close();
            conn_status = false;
            $( "#ChatMensagens" ).html( '' );
        }

        conn = new ab.Session( 'ws://localhost:3000',
            function () {
                conn_status = true;
                conn.subscribe( room, function ( topic, data ) {
                    console.log( data );
                    if ( typeof data === 'string' ) {
                        data = JSON.parse( data );

                        for ( var i = 0; i < data.length; i++ ) {
                            exibeMsg( data[ i ] );
                        }
                    } else {
                        exibeMsg( data );
                    }
                } );
            },
            function () {
                console.warn( 'A conexão foi encerrada' );
            }, {
                'skipSubprotocolCheck': true
            }
        );
    }


    //Printar Mensagens na Tela
    function exibeMsg( dados ) {
        var m;
        var n;
        var t;
        var d = new Date();
        dataHora = ( d.toLocaleString() );

        if ( dados.nome != 'Suporte' ) {
            m = "right";
            n = 'right';
            t = 'left';
        } else {
            m = "left";
            n = 'left';
            t = 'right';
            $( "#qtdUsuarios" ).hide( 500 );
        }

        text = '<div class="msg" >' +
            '<div class="direct-chat-msg ' + m + '">' +
            '<div class="direct-chat-infos clearfix">' +
            '<span class="direct-chat-name float-' + n + '">' + dados.nome + '</span>' +
            '<span class="direct-chat-timestamp float-' + t + '">' + dataHora + 'Hs</span>' +
            '</div>' +
            '<img class="direct-chat-img" src="' + dados.imagem + '" alt="' + dados.nome + '">' +
            '<div class="direct-chat-text">' + dados.texto + '</div>' +
            '</div></div>';
        $( "#ChatMensagens" ).append( text ).animate( {
            scrollTop: $( "#ChatMensagens" ).prop( "scrollHeight" )
        }, 500 );
    }

    $( "#enviaMsg" ).submit( function () {
        if ( $( "#chat-mensagem" ).val() != '' ) {
            var msg = {
                'sala': room,
                'nome': $( "#chat-mensagem" ).attr( 'name' ),
                'imagem': $( "#chat-mensagem" ).attr( 'img' ),
                'texto': $( "#chat-mensagem" ).val()
            };
            $( "#slide-smile" ).removeClass( "direct-chat-contacts-open" );

            conn.publish( room, msg );
            //exibeMsg(msg);
            $( "#chat-mensagem" ).val( '' ).focus();
        }
        return false;
    } );

} )