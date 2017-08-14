var init_age_calculator;

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

$(document).ready(function functionName() {
  init_age_calculator();
})
