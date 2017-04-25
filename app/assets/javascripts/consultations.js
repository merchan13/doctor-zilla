$(document).ready(function() {
    var wrapper         = $(".procedures_wrap");
    var data_wrapper         = $(".procedures_data_wrap");
    var add_button      = $(".add_select_button");

    $(add_button).click(function(e){
        e.preventDefault();
        var value = $( "#procedures" ).val();
        var name = $( "#procedures option:selected" ).text();

        if (value.length > 0){
          $(data_wrapper).append("<input type='hidden' name='procedures_ids[]' value='"+ value +"' class='form-control'>");
          $(wrapper).append("<input type='text' name='procedures_name[]' value='"+ name +"' class='form-control' disabled>");
        }        
    })

    $(wrapper).on("click",".remove_field", function(e){
        e.preventDefault(); $(this).parent('div').remove(); x--;
    })
});
