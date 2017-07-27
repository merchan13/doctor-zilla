var init_age_calculator;

init_age_calculator = function() {
  $('#medical_record_birthday').datepicker("option", "onSelect", function(dateText, inst) {
    var dob = $(this).datepicker('getDate');
    var age = GetAge(dob);
    if (age >= 16 && age < 18) {
        alert("The minimum age requirement for supplementary card applicant is 18 years old. For applicant aged 16 and 17, and are going overseas to study, please submit the letter of acceptance from the education institution.");
    }
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

//#medical_record_birthday
//#age_text
