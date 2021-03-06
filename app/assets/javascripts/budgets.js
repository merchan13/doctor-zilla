var budget_update_procedures;
var budget_update_equipments;
var budget_add_procedures_to_list;
var budget_add_equipments_to_list;
var check_bugdet_elements;

budget_add_procedures_to_list = function() {
    var wrapper         = $(".budget_procedures_wrap");
    var data_wrapper    = $(".budget_procedures_data_wrap");
    var add_button      = $(".budget_add_procedure_button");
    var x = 0;

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#procedures_select" ).val();
        var name = $( "#procedures_select option:selected" ).text();

        if (value.length > 0){
          var field_html = "<div id='UIprocedure"+ value +"'>"
                              +"<div class='col-md-8 form-group' style='margin-right:0; margin-left:0'>"
                                  +"<input type='text' name='procedures_name[]' value='"+ name +"' class='form-control bg-element' disabled></div>"
                              +"<div class='col-md-3 form-group' style='margin-right:0; margin-left:-15px'>"
                                  +"<input type='number' name='procedures_cost[]' placeholder='Costo' class='form-control cost' onchange='update_cost()' required></div>"
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

budget_add_equipments_to_list = function() {
    var wrapper         = $(".budget_equipments_wrap");
    var data_wrapper    = $(".budget_equipments_data_wrap");
    var add_button      = $(".budget_add_equipment_button");
    var x = 0;

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#equipments_select" ).val();
        var name = $( "#equipments_select option:selected" ).text();

        if (value.length > 0){
          var field_html = "<div id='UIequipment"+ value +"'>"
                              +"<div class='col-md-8 form-group' style='margin-right:0; margin-left:0'>"
                                  +"<input type='text' name='equipments_name[]' value='"+ name +"' class='form-control bg-element' disabled></div>"
                              +"<div class='col-md-3 form-group' style='margin-right:0; margin-left:-15px'>"
                                  +"<input type='number' name='equipments_cost[]' placeholder='Costo' class='form-control cost' onchange='update_cost()' required></div>"
                              +"<div class='col-md-1 form-group'>"
                                  +"<button type='button' name='button' value='"+ value +"' class='btn btn-danger remove_equipment_button'>X</button></div>"
                            +"</div>";

          $(data_wrapper).append("<input type='hidden' id='DATAequipment"+ value +"' name='equipments[]' value='"+ value +"' class='form-control'>");
          $(wrapper).append(field_html);
          x++;
        }
    });

    $(wrapper).on("click",".remove_equipment_button", function(e){
        e.preventDefault();

        var val = $(this).val();

        $("#UIequipment"+ val +"").remove();
        $("#DATAequipment"+ val +"").remove();
        x--;

        update_cost();
    });
}

budget_update_procedures = function() {
  $('#new-procedure-form-bg').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-bg').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-procedure-form-bg').on('ajax:success', function(event, data, status){
    $('#procedures_select').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-procedure-modal-bg').modal('hide');
    $('#new-procedure-form-bg').find('input:text').val('');
    $('#new-procedure-form-bg').find('input').css("border-color", "#ccc");

    var alert_html = '<div id=' + '"procedure-taken"' + '></div>';

    $('#procedure-taken').replaceWith(alert_html);
  });

  $('#new-procedure-form-bg').on('ajax:error', function(event, xhr, status, error){
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

budget_update_equipments = function() {
  $('#new-equipment-form-bg').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form-bg').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-equipment-form-bg').on('ajax:success', function(event, data, status){
    $('#equipments_select').append("<option value='"+ data.id +"' selected>"+ data.name +"</option>");
    $('#new-equipment-modal-bg').modal('hide');
    $('#new-equipment-form-bg').find('input:text').val('');
    $('#new-equipment-form-bg').find('input').css("border-color", "#ccc");

    var alert_html = '<div id=' + '"equipment-taken"' + '></div>';

    $('#equipment-taken').replaceWith(alert_html);
  });

  $('#new-equipment-form-bg').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"equipment-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Debe ingresar un nombre Equipo Médico</div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El Equipo que usted ingresó ya existe</div>';
    }

    $('#equipment-taken').replaceWith(alert_html);
  });
}

check_bugdet_elements = function() {
  $('#new_budget').submit(function() {
    var bgElements = $(".bg-element").length;

    if (bgElements == 0){
      var alert_html = "<div id='no-elements-alert' class='alert alert-danger col-md-12' "
                       + "style='float:none;margin-bottom:0;'><strong>Alerta!</strong> "
                       + "Debe agregar al menos un Procedimiento o un Equipo para poder realizar el presupuesto.</div>"

      $('#no-elements-alert').replaceWith(alert_html);
      window.scrollTo(0, 0);

      return false;
    }

    return true;
  });
}

function update_cost() {
    var new_cost = 0;

    $('.cost').each(function(i) {
      if ($(this).val() != ''){
          new_cost = new_cost + parseInt($(this).val(), 10);
      }
    });

    $('#budget_cost').val(new_cost);
}

$(document).ready(function functionName() {
  budget_update_procedures();
  budget_update_equipments();
  budget_add_procedures_to_list();
  budget_add_equipments_to_list();
  check_bugdet_elements();
})
