var add_fields;
var update_medicines;

update_medicines = function() {
  $('#new-medicine-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#new-medicine-form').on('ajax:after', function(event, data, status){
    show_spinner();
  });

  $('#new-medicine-form').on('ajax:success', function(event, data, status){
    var display = data.generic_name + ' (' + data.comercial_name + ') - Vía ' + data.dose_way + ', ' + data.dose_presentation + ' de ' + data.dose_quantity + data.dose_unit

    $('.medicine_form').append("<option value='"+ data.id +"'>"+ display +"</option>");
    $('#new-medicine-modal').modal('hide');
    $('#new-medicine-form').find('input').val('');
    $('#new-medicine-form').find('select').val('');
    $('#new-medicine-form').find('input').css("border-color", "#ccc");

    var alert_html = '<div id=' + '"medicine-taken"' + '></div>';

    $('#medicine-taken').replaceWith(alert_html);
  });

  $('#new-medicine-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();

    var alert_html = '<div id=' + '"medicine-taken"'
    + 'class=' + '"alert alert-danger col-md-12"'
    + 'style=' + '"float:none"';

    if (error == 'Bad Request'){
      alert_html = alert_html + '> <strong>Alerta!</strong> Verifique que haya ingresado todos los datos. </div>';
    }

    if (error == 'Not Acceptable'){
      alert_html = alert_html + '> <strong>Alerta!</strong> El medicamento que usted ingresó ya existe y/o se posee una receta para el mismo. </div>';
    }

    $('#medicine-taken').replaceWith(alert_html);
  });
}
add_fields = function() {
    var add_button = $(".add_medicine_button");
    var x = 0;

    $(add_button).click(function(e){
      e.preventDefault();

      var clone = $(".clone-test").last().clone();

      var lastMedicine = $(".clone-test").last();

      if (x == 0) {
        clone.insertAfter(lastMedicine).append("<div class='col-md-2' style='top:-200px;'><button type='button' name='button' class='btn btn-danger remove_medicine_button'>Borrar medicamento</button></div>")
                                       .find("input[type='number']").val("").end()
                                       .find("input[type='number']").css("border-color", "#ccc").end()
                                       .find("textarea").val("").end()
                                       .find("textarea").css("border-color", "#ccc");
        x++;
      } else {
        clone.insertAfter(lastMedicine).find("input[type='number']").val("").end()
                                       .find("input[type='number']").css("border-color", "#ccc").end()
                                       .find("textarea").val("").end()
                                       .find("textarea").css("border-color", "#ccc");
        x++;
      }

      $("<div class='col-md-12 separador'><hr></div>").insertBefore( $(".clone-test").last() );

    })

    $("#new_prescription").on("click",".remove_medicine_button", function(e){
        e.preventDefault();

        $(this).parent().parent().remove();
        $(".separador").last().remove();
        x--;
    })
}

$(document).ready(function functionName() {
  add_fields();
  update_medicines();
})
