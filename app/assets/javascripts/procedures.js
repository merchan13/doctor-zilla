var update_procedures;

update_procedures = function() {
  $('#new-procedure-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form').on('ajax:success', function(event, data, status){
    $('#procedures').last().append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-form').modal('hide');
  });
}

$(document).ready(function functionName() {
  update_procedures();
})
