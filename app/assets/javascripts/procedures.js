var update_procedures;

init_procedure_form = function() {
  $('#new-procedure-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form').on('ajax:success', function(event, data, status){
    $('#_procedure_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-modal').modal('hide');
    $('#new-procedure-form').find('input:text').val('');

    var alert_html = '<div id=' + '"procedure-taken"' + '></div>';

    $('#procedure-taken').replaceWith(alert_html);
    init_procedure_form();
  });

  $('#new-procedure-form').on('ajax:error', function(event, xhr, status, error){
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

$(document).ready(function functionName() {
  init_procedure_form();
})
