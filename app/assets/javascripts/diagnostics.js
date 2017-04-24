var update_diagnostics;

update_diagnostics = function() {
  $('#new-diagnostic-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-diagnostic-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-diagnostic-form').on('ajax:success', function(event, data, status){
    $('#consultation_diagnostic_id').append("<option value='"+ data.id +"' selected>"+ data.description +"</option>");
    $('#new-diagnostic-form').modal('hide');
  });
}

$(document).ready(function functionName() {
  update_diagnostics();
})
