var update_insurances;

update_insurances = function() {
  $('#new-insurance-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:success', function(event, data, status){
    $('#medical_record_insurance_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-insurance-form').modal('hide');
  });
}

$(document).ready(function functionName() {
  update_insurances();
})
