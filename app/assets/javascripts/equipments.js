var update_equipments;

init_equipment_form = function() {
  $('#new-equipment-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form').on('ajax:success', function(event, data, status){
    $('#_equipment_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-equipment-modal').modal('hide');
    $('#new-equipment-form').find('input:text').val('');

    var alert_html = '<div id=' + '"equipment-taken"' + '></div>';

    $('#equipment-taken').replaceWith(alert_html);
    init_equipment_form();
  });

  $('#new-equipment-form').on('ajax:error', function(event, xhr, status, error){
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
  init_equipment_form();
})
