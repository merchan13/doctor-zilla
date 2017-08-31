var opnt_update_procedures;
var opnt_add_procedures_to_list;
var check_opnt_elements;


opnt_update_procedures = function() {
  $('#new-procedure-form-o').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-o').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-o').on('ajax:success', function(event, data, status){
    $('#procedures_select').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-modal-o').modal('hide');
    $('#new-procedure-form-o').find('input:text').val('');
    $('#new-procedure-form-o').find('input').css('border-color', '#ccc');

    var alert_html = '<div id=' + '"procedure-taken"' + '></div>';

    $('#procedure-taken').replaceWith(alert_html);
  });

  $('#new-procedure-form-o').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"procedure-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre Procedimiento y su breve descripción. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Procedimiento que usted ingresó ya existe. </div>';
    }

    $('#procedure-taken').replaceWith(alert_html);
  });
}

opnt_add_procedures_to_list = function() {
    var wrapper         = $(".opnt_procedures_wrap");
    var data_wrapper    = $(".opnt_procedures_data_wrap");
    var add_button      = $(".opnt_add_procedure_button");
    var x = 0;

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#procedures_select" ).val();
        var name = $( "#procedures_select option:selected" ).text();

        if (value.length > 0){
          var field_html = "<div id='UIprocedure"+ value +"'>"
                              +"<div class='col-md-8 form-group' style='margin-right:0; margin-left:0'>"
                                  +"<input type='text' name='procedures_name[]' value='"+ name +"' class='form-control' disabled></div>"
                              +"<div class='col-md-1 form-group'>"
                                  +"<button type='button' name='button' value='"+ value +"' class='btn btn-danger remove_procedure_button'>X</button></div>"
                            +"</div>";

          $(data_wrapper).append("<input type='hidden' id='DATAprocedure"+ value +"' name='procedures[]' value='"+ value +"' class='form-control procedure-list-item'>");
          $(wrapper).append(field_html);
          x++;
        }
    });

    $(wrapper).on("click",".remove_procedure_button", function(e){
        e.preventDefault();

        var val = $(this).val();

        $("#UIprocedure"+ val +"").remove();
        $("#DATAprocedure"+ val +"").remove();
        x--;

        update_cost();
    });
}

check_opnt_elements = function() {
  $('#new_operative_note').submit(function() {
    var gotValue = false;
    var proceduresCheck = $('.procedure-check');
    var proceduresList = $('.procedure-list-item');

    proceduresCheck.each(function() {
      if ( $(this).is(':checked') ){
        gotValue = true;
      }
    });

    if (proceduresList.length > 0){
      gotValue = true;
    }

    if (gotValue){
      return true;
    }

    var alert_html = "<div id='no-procedures-alert' class='alert alert-danger col-md-12' "
                     + "style='float:none;margin-bottom:0;'><strong>Alerta!</strong> "
                     + "Debe agregar al menos un Procedimiento</div>"

    $('#no-procedures-alert').replaceWith(alert_html);
    window.scrollTo(0, 0);

    return false;
  });
}

$(document).ready(function() {
  opnt_update_procedures();
  opnt_add_procedures_to_list();
  check_opnt_elements();
});
