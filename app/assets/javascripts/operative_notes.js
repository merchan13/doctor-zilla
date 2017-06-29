$(document).ready(function() {
    var wrapper         = $(".opnts_procedures_wrap");
    var data_wrapper    = $(".opnts_procedures_data_wrap");
    var add_button      = $(".opnts_add_select_button");

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#procedures_select" ).val();
        var name = $( "#procedures_select option:selected" ).text();

        if (value.length > 0){
          $(data_wrapper).append("<input type='hidden' name='procedures[]' value='"+ value +"' class='form-control'>");
          $(wrapper).append("<input type='text' name='procedures_name[]' value='"+ name +"' class='form-control' disabled>");
        }
    })

    $(wrapper).on("click",".remove_field", function(e){
        e.preventDefault(); $(this).parent('div').remove();
        x--;
    })
});
