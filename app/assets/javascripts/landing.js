//= require landing/jquery-1.11.1.min
//= require jquery_ujs
//= require landing/jquery-migrate-1.2.1
//= require landing/modernizr-2.6.1.min
//= require landing/conditional
//= require landing/plugins
//= require landing/jquery.inview
//= require retina_tag
//= require landing/bp-script
//= require landing/jquery.sticky
//= require landing/jquery.scrollTo-min
//= require landing/jquery.nav
//= require landing/jquery.fitvids.js

$(window).load(function(){
  $("#header_wrapper").sticky({ topSpacing: 0 });
});

(function($){
  $(document).ready(function() {
    /* This code is executed after the DOM has been completely loaded */
    $("#nav li a, a.scrool").click(function(e){
      var full_url = this.href;
      var parts = full_url.split("#");
      var trgt = parts[1];
      var target_offset = $("#"+trgt).offset();
      var target_top = target_offset.top;
      $('html,body').animate({scrollTop:target_top -70}, 1000);
      return false;
    });
  });
})(jQuery);

$(document).ready(function() {
    $('#nav').onePageNav({
        filter: ':not(.external)',
        scrollThreshold: 0.25
    });
});

$(function(){
    var shrinkHeader = 5;
    $(window).scroll(function() {
        var scroll = getCurrentScroll();
        if ( scroll >= shrinkHeader ) {
          $('#header_wrapper').addClass('shrink');
        }
        else {
          $('#header_wrapper').removeClass('shrink');
        }
    });
    function getCurrentScroll() {
        return window.pageYOffset;
    }
});
$("#container").fitVids();
