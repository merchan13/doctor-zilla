var init_activities_summary;

init_activities_summary = function() {
  $('#get-activities-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#get-activities-form').on('ajax:success', function(event, data, status){
    $('#activities-errors').replaceWith('<div class="col-md-12" id="activities-errors"></div>');
    $('#custom-summary-results').replaceWith(data);
    hide_spinner();
    $(document)
    .on('redraw.bs.charts', function () {
    })
    .trigger('redraw.bs.charts')
    $('#general').removeClass('active')
    $('#custom').addClass('active')
    init_activities_summary();
  });

  $('#get-activities-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    var resetResults = '<div id="custom-summary-results"></div>';
    var errors = '<div class="col-md-12" id="activities-errors"><h4>Por favor introduzca un intévalo de fechas válido</h4></div>';

    $('#custom-summary-results').replaceWith(resetResults);
    $('#activities-errors').replaceWith(errors);
  });
}

$(document).ready(function functionName() {
  init_activities_summary();
})
