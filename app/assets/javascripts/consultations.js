var consultation_update_reasons;
var consultation_update_diagnostics;
var consultation_update_procedures;
var consultation_add_procedures_to_list;
var init_imc_calculator;

consultation_update_reasons = function() {
  $('#new-reason-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-reason-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-reason-form').on('ajax:success', function(event, data, status){
    $('#consultation_reason_id').append("<option value='"+ data.id +"' selected>"+ data.description +"</option>");
    $('#new-reason-modal').modal('hide');
    $('#new-reason-form').find('input:text').val('');

    var alert_html = '<div id=' + '"reason-taken"' + '></div>';

    $('#reason-taken').replaceWith(alert_html);
    init_reason_form();
  });

  $('#new-reason-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"reason-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un motivo de consulta. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El motivo de consulta que usted ingresó ya existe. </div>';
    }

    $('#reason-taken').replaceWith(alert_html);
  });
}

consultation_update_diagnostics = function() {
  $('#new-diagnostic-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-diagnostic-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-diagnostic-form').on('ajax:success', function(event, data, status){
    $('#consultation_diagnostic_id').append("<option value='"+ data.id +"' selected>"+ data.description +"</option>");
    $('#new-diagnostic-modal').modal('hide');
    $('#new-diagnostic-form').find('input:text').val('');

    var alert_html = '<div id=' + '"diagnostic-taken"' + '></div>';

    $('#diagnostic-taken').replaceWith(alert_html);
    init_reason_form();
  });

  $('#new-diagnostic-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"diagnostic-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un diagnóstico. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El diagnóstico que usted ingresó ya existe. </div>';
    }

    $('#diagnostic-taken').replaceWith(alert_html);
  });
}

consultation_update_procedures = function() {
  $('#new-procedure-form-c').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-c').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-c').on('ajax:success', function(event, data, status){
    $('#procedures_select').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-modal-c').modal('hide');
    $('#new-procedure-form-c').find('input:text').val('');

    var alert_html = '<div id=' + '"procedure-taken"' + '></div>';

    $('#procedure-taken').replaceWith(alert_html);
    init_procedure_form();
  });

  $('#new-procedure-form-c').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"procedure-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre Procedimiento y su breve descripción. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Procedimiento que usted ingresó ya existe. </div>';
    }

    $('#procedure-taken').replaceWith(alert_html);
  });
}

consultation_add_procedures_to_list = function() {
    var wrapper         = $(".consultation_procedures_wrap");
    var data_wrapper    = $(".consultation_procedures_data_wrap");
    var add_button      = $(".consultation_add_procedure_button");
    var x = 0;

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#procedures_select" ).val();
        var name = $( "#procedures_select option:selected" ).text();

        if (value.length > 0){
          var field_html = "<div id='UIprocedure"+ value +"'>"
                              +"<div class='col-md-8 form-group' style='margin-right:0; margin-left:0'>"
                                  +"<input type='text' name='procedures_name[]' value='"+ name +"' class='form-control' disabled></div>"
                              +"<div class='col-md-1 form-group'>"
                                  +"<button type='button' name='button' value='"+ value +"' class='btn btn-danger remove_procedure_button'>X</button></div>"
                            +"</div>";

          $(data_wrapper).append("<input type='hidden' id='DATAprocedure"+ value +"' name='procedures[]' value='"+ value +"' class='form-control'>");
          $(wrapper).append(field_html);
          x++;
        }
    });

    $(wrapper).on("click",".remove_procedure_button", function(e){
        e.preventDefault();

        var val = $(this).val();

        $("#UIprocedure"+ val +"").remove();
        $("#DATAprocedure"+ val +"").remove();
        x--;

        update_cost();
    });
}

init_imc_calculator = function() {
  $('.imc-changer').change(function() {
    var weightInput = $('#consultation_weight').val();
    var heightInput = $('#consultation_height').val();

    if (weightInput != "" && heightInput != ""){
      var weight = parseInt(weightInput, 10);
      var heightInCm = parseInt(heightInput, 10)/100;

      var height2 = heightInCm * heightInCm;

      var imc = weight/height2;

      $('#imc-text').text(imc.toFixed(2));
    }
  });
}

function completePressureRequired(input){
  var pressureS = $('#consultation_pressure_s').val();
  var pressureD = $('#consultation_pressure_d').val();

  if (pressureS == "" && pressureD == ""){
    $('#consultation_pressure_s').removeAttr("required");
    $('#consultation_pressure_d').removeAttr("required");
  } else if (pressureS != "" || pressureD != ""){
    $('#consultation_pressure_s').attr("required", true);
    $('#consultation_pressure_d').attr("required", true);
  }
}

function normalAbnormalCheck(system) {
    if (document.getElementById(system + '_abnormal').checked) {
        document.getElementById('if_'+ system +'_abnormal').style.display = 'block';
    }
    else document.getElementById('if_'+ system +'_abnormal').style.display = 'none';

}

$(document).ready(function functionName() {
  consultation_update_reasons();
  consultation_update_diagnostics();
  consultation_update_procedures();
  consultation_add_procedures_to_list();
  init_imc_calculator();
})
