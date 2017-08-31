var home_update_procedures;
var home_update_equipments;

home_update_procedures = function() {
  $('#new-procedure-form-home').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-home').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-home').on('ajax:success', function(event, data, status){
    $('#procedures_select').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-modal-home').modal('hide');
    $('#new-procedure-form-home').find('input:text').val('');
    $('#new-procedure-form-home').find('input').css("border-color", "#ccc");

    var alert_html = '<div id=' + '"procedure-taken"' + '></div>';

    $('#procedure-taken').replaceWith(alert_html);
  });

  $('#new-procedure-form-home').on('ajax:error', function(event, xhr, status, error){
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

home_update_equipments = function() {
  $('#new-equipment-form-home').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form-home').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form-home').on('ajax:success', function(event, data, status){
    $('#_equipment_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-equipment-modal-home').modal('hide');
    $('#new-equipment-form-home').find('input:text').val('');
    $('#new-equipment-form-home').find('input').css("border-color", "#ccc");

    var alert_html = '<div id=' + '"equipment-taken"' + '></div>';

    $('#equipment-taken').replaceWith(alert_html);
  });

  $('#new-equipment-form-home').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"equipment-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre Equipo Médico</div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Equipo que usted ingresó ya existe</div>';
    }

    $('#equipment-taken').replaceWith(alert_html);
  });
}

$(document).ready(function functionName() {
  home_update_procedures();
  home_update_equipments();
})
