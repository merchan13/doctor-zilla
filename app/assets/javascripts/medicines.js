var update_medicines;

update_medicines = function() {
  $('#new-medicine-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-medicine-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-medicine-form').on('ajax:success', function(event, data, status){
    $('.medicine_form').append("<option value='"+ data.id +"'>"+ data.generic_name +"</option>");
    $('#new-medicine-form').modal('hide');
  });

}

$(document).ready(function functionName() {
  update_medicines();
})
