// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).foundation();

$(document).ready(function(){
  //spin 'favorite' star when hover.
  $('.icon-star').mouseenter(function(){
    $(this).addClass('icon-spin').mouseleave(function(){
      $(this).removeClass('icon-spin');
    });
  })
  // clicking on the 'favorite' star will toggle it from blue to grey.
  $('.icon-star').click(function(){
    $(this).toggleClass('icon-muted');
  });

  $('form').submit(function(){
    $('.mylink-button').html("<i class='icon-spinner icon-spin icon-large'></i>");
    $('.mylink-button').css('width', '119px');
    $('.mylink-button').attr('disabled', 'disabled');
  });
  //fix the side nav if you start scrolling down.
  $(window).scroll(function(){

    if ($(window).scrollTop() >= 227){
      $('.tagcloud').css("position", "fixed").css("left", "75.1%").css("top", "70px").css("width", "186px")
    } else {
      $('.tagcloud').css("position", "static");
    }
    // $('.tagcloud').css("top", Math.max(150,100-$(this).scrollTop()));
  });
});