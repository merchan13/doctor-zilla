var init_record_lookup;
var show_consultation;

init_record_lookup = function() {
  $('#record-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#record-lookup-form').on('ajax:after', function(event, data, status){
    hide_spinner();
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

function documentTypeSelected(docType) {
    var type = docType.value;

    if (type == 'V' || type == 'E'){
      $('#medical_record_document').attr("pattern", '^[0-9]{4,12}$');
      $('#medical_record_document').attr("title", 'Debe introducir un número de cédula válido (No se aceptan letras ni caracteres especiales)');
    } else if (type == 'P'){
      $('#medical_record_document').attr("pattern", '^[a-zA-Z0-9]{2,41}$');
      $('#medical_record_document').attr("title", 'Debe introducir un número de pasaporte válido (No se aceptan caracteres especiales, sólo letras y números)');
    }
}

$(document).ready(function functionName() {
  init_record_lookup();
  show_consultation();
})
