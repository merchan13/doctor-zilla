var update_occupations;

update_occupations = function() {
  $('#new-occupation-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-occupation-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-occupation-form').on('ajax:success', function(event, data, status){
    $('#medical_record_occupation_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-occupation-form').modal('hide');
  });
}

$(document).ready(function functionName() {
  update_occupations();
})
