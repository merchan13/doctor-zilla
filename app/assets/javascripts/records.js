var init_record_lookup;
var show_consultation;

init_record_lookup = function() {
  $('#record-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#record-lookup-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#record-lookup-form').on('ajax:success', function(event, data, status){
    $('#record-lookup').replaceWith(data);
    init_record_lookup();
  });

  $('#record-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#record-lookup-results').replaceWith(' ');
    $('#record-lookup-errors').replaceWith('No se encontró ninguna historia que coincida con ese criterio de busqueda.');
  });
}

show_consultation = function() {
  $(".consultation-button").click(function(){
    var data = $.parseJSON($(this).attr('data-button'));

    if ($("#consultation"+data).is(':visible')) {
      $(this).text('[ Ver más... ]');
    } else {
      $(this).text('[ Ver menos ]');
    }

    $("#consultation"+data).toggle();
  });
}

$(document).ready(function functionName() {
  init_record_lookup();
  show_consultation();
})
