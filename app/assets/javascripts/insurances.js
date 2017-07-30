var update_insurances;

init_insurance_form = function() {
  $('#new-insurance-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:success', function(event, data, status){
    $('#medical_record_insurance_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-insurance-modal').modal('hide');
    $('#new-insurance-form').find('input:text').val('');

    var alert_html = '<div id=' + '"insurance-taken"' + '></div>';

    $('#insurance-taken').replaceWith(alert_html);
    init_insurance_form();
  });

  $('#new-insurance-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"insurance-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre Seguro. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Seguro que usted ingresó ya existe. </div>';
    }

    $('#insurance-taken').replaceWith(alert_html);
  });
}

$(document).ready(function functionName() {
  init_insurance_form();
})
