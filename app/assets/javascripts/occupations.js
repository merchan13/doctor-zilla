var update_occupations;

init_occupation_form = function() {
  $('#new-occupation-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-occupation-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-occupation-form').on('ajax:success', function(event, data, status){
    $('#medical_record_occupation_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-occupation-modal').modal('hide');
    $('#new-occupation-form').find('input:text').val('');

    var alert_html = '<div id=' + '"occupation-taken"' + '></div>';

    $('#occupation-taken').replaceWith(alert_html);
    init_occupation_form();
  });

  $('#new-occupation-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"occupation-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar una profesión. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> La profesión que usted ingresó ya existe. </div>';
    }

    $('#occupation-taken').replaceWith(alert_html);
  });
}

$(document).ready(function functionName() {
  init_occupation_form();
})
