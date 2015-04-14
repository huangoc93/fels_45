// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

ready = function() {
  $('#user_avatar').bind('change', function() {
    size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 2)
      alert('Maximum file size is 2MB. Please choose a smaller file.');
    else
      $('#box_show_img').attr('src', URL.createObjectURL(this.files[0]));
  });

  $('#category_avatar').bind('change', function() {
    size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5)
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    else
      $('#box_show_img').attr('src', URL.createObjectURL(this.files[0]));
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

$(document).on("click", '.remove-answer', function(){
  $(this).siblings("input[type='hidden']").val(1);
  $(this).parent().parent().hide();
});

$(document).on("click", '#add_answer', function(){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_answer", "g");
  $(this).parent().parent().before(
          $("#answer_template").html().replace(regexp, new_id));
});