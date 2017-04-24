var update_reasons;

update_reasons = function() {
  $('#new-reason-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-reason-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-reason-form').on('ajax:success', function(event, data, status){
    $('#consultation_reason_id').append("<option value='"+ data.id +"' selected>"+ data.description +"</option>");
    $('#new-reason-form').modal('hide');
  });
}

$(document).ready(function functionName() {
  update_reasons();
})
