var add_fields;

add_fields = function() {
    var add_button      = $(".add_medicine_button");
    var x = 0;

    $(add_button).click(function(e){
      e.preventDefault();

      var clone = $(".clone-test").last().clone();

      //$(".clone-test").last().append("<div class='col-md-12'><hr></div>");

      var lastMedicine = $(".clone-test").last();

      if (x == 0) {
        clone.insertAfter(lastMedicine).append("<button type='button' name='button' class='btn btn-danger remove_medicine_button'>Borrar medicamento</button>").find("input[type='number']").val("").end().find("textarea").val("");
        x++;
      } else {
        clone.insertAfter(lastMedicine).find("input[type='number']").val("").end().find("textarea").val("");
        x++;
      }

      $("<div class='col-md-12 separador'><hr></div>").insertBefore( $(".clone-test").last() );

    })

    $("#new_prescription").on("click",".remove_medicine_button", function(e){
        e.preventDefault();

        $(this).parent().remove();
        $(".separador").last().remove();
        x--;
    })
}

$(document).ready(function functionName() {
  add_fields();
})
