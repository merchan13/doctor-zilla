var init_record_lookup;
var show_consultation;
var update_occupations;
var update_insurances;
var init_age_calculator;

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

update_occupations = function() {
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
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre de profesión. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> La profesión que usted ingresó ya existe. </div>';
    }

    $('#occupation-taken').replaceWith(alert_html);
  });
}

update_insurances = function() {
  $('#new-insurance-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-insurance-form').on('ajax:success', function(event, data, status){
    $('#medical_record_insurance_id').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-insurance-modal').modal('hide');
    $('#new-insurance-form').find('input:text').val('');

    var alert_html = '<div id=' + '"insurance-taken"' + '></div>';

    $('#insurance-taken').replaceWith(alert_html);
    init_insurance_form();
  });

  $('#new-insurance-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"insurance-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre de una Aseguradora. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Seguro que usted ingresó ya existe. </div>';
    }

    $('#insurance-taken').replaceWith(alert_html);
  });
}

init_age_calculator = function() {
  $('#medical_record_birthday').datepicker()
    .on('changeDate', function(e) {
        var bday = $('#medical_record_birthday').val().split("/");
        var birthDate = new Date(bday[2], bday[1] - 1, bday[0]);

        var age = GetAge(birthDate);

        $('#age_text').text(age + ' años');
    });

  function GetAge(birthDate) {
      var today = new Date();
      var age = today.getFullYear() - birthDate.getFullYear();
      var m = today.getMonth() - birthDate.getMonth();
      if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
          age--;
      }
      return age;
  }
}

function documentTypeSelected(docType) {
    var type = docType.value;

    if (type == 'V' || type == 'E'){
      $('#medical_record_document').attr("pattern", '^[0-9]{4,8}$');
      $('#medical_record_document').attr("title", 'Debe introducir un número de cédula válido (No se aceptan letras ni caracteres especiales)');
    } else if (type == 'P'){
      $('#medical_record_document').attr("pattern", '^[a-zA-Z0-9]{2,41}$');
      $('#medical_record_document').attr("title", 'Debe introducir un número de pasaporte válido (No se aceptan caracteres especiales, sólo letras y números)');
    }
}

function isOldRecord(input) {
  if (input.checked) {
    $("#medical_record_old_record_number").toggle();
    $("#medical_record_old_record_number").attr("required", true);
  }
  else {
    $("#medical_record_old_record_number").toggle();
    $("#medical_record_old_record_number").val('');
    $("#medical_record_old_record_number").removeAttr("required");
  }
}

$(document).ready(function functionName() {
  init_record_lookup();
  show_consultation();
  update_occupations();
  update_insurances();
  init_age_calculator();
})
