// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
// require bootstrap-sprockets
//= require bootstrap-datepicker
// require turbolinks
//= require_tree .

$("form").on("keypress", function (e) {
    if (e.keyCode == 13) {
        return false;
    }
});

var hide_spinner = function(){
  $('#spinner').hide();
}

var show_spinner = function(){
  $('#spinner').show();
}

function blockCharacters(input){
  var stripped = input.value.replace(/[^a-zA-Záäéëíïóöúüñ \/\-,.:;()0-9\s]+/gi, '');
  input.value = stripped;
}

function validateTextArea(textArea){
    var regex = new RegExp("^[a-zA-Záäéëíïóöúüñ \\-,.:;()0-9]+");

    var match = regex.test(textArea.value);

    if (match == false && textArea.value != "") {
      textArea.style.borderColor = "red";
    }
    else if (match == false && textArea.value == "") {
      textArea.style.borderColor = "#ccc";
    }
    else {
      textArea.style.borderColor = "#00e500"
    }
}

function validateTextField(textField){
    var valid = textField.checkValidity();

    if (valid == false && textField.value != "") {
      textField.style.borderColor = "red";
    }
    else if (textField.value == "") {
      textField.style.borderColor = "#ccc";
    }
    else {
      textField.style.borderColor = "#00e500"
    }
}
