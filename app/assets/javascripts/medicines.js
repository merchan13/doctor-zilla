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
    $('#new-medicine-modal').modal('hide');
    $('#new-medicine-form').find('input:text').val('');
    $('#new-medicine-form').find('input:number').val('');
    $('#new-medicine-form').find('select').val('');

    var alert_html = '<div id=' + '"occupation-erros"' + '></div>';

    $('#occupation-error').replaceWith(alert_html);
    update_medicines();
  });
}

$(document).ready(function functionName() {
  update_medicines();
})
