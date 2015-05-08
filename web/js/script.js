$(function(){
    
    // Modalne okno pri novych terminoch
    $('#myModal').modal();

    $('.upload').each(function () {
        var ul = $('ul', this);
        
        // Simulacia kliknutia na 'browse' - drop files
        $('.drop a', this).click(function(){
            $(this).parent().find('input').click();
        });

        // jQuery File Upload plugin
        $(this).fileupload({

            // Definovanie drop elementu
            dropZone: $('.drop', this),

            // Ked je subor nahraty
            add: function (e, data) {

                var tpl = $('<li class="working"><input type="text" value="0" data-width="48" data-height="48"'+
                    ' data-fgColor="#0788a5" data-readOnly="1" data-bgColor="#3e4043" /><p></p><span></span></li>');

                // Vypisat nazov suboru a velkost
                tpl.find('p').text(data.files[0].name)
                             .append('<i>' + formatFileSize(data.files[0].size) + '</i>');

                // Vytvorit zoznam suborov
                data.context = tpl.appendTo(ul);

                // Knob plugin
                tpl.find('input').knob();

                // Kliknutia na zrusenie alebo zmazanie
                tpl.find('span').click(function(){

                    if(tpl.hasClass('working')){
                        jqXHR.abort();
                    }

                    tpl.fadeOut(function(){
                        tpl.remove();
                    });

                });

                // Automaticky zaciatok nahravania
                var jqXHR = data.submit();
            },

            progress: function(e, data){

                // Priebeh nahravania v %
                var progress = parseInt(data.loaded / data.total * 100, 10);
                
                data.context.find('input').val(progress).change();

                if(progress == 100){
                    data.context.removeClass('working');
                }
            },

            fail:function(e, data){
                // Chyba
                data.context.addClass('error');
            }

        });
    });

    $(document).on('drop dragover', function (e) {
        e.preventDefault();
    });

    // Formatovanie velkosti nahrateho suboru
    function formatFileSize(bytes, si) {
        var thresh = si ? 1000 : 1024;
        if(bytes < thresh) return bytes + ' B';
        var units = ['KB','MB','GB','TB','PB','EB','ZB','YB'];
        var u = -1;
        do {
            bytes /= thresh;
            ++u;
        } while(bytes >= thresh);
        return bytes.toFixed(2)+' '+units[u];
    }

});