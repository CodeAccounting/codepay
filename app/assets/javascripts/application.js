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
//= require jquery-1.10.2.min
//= require jquery_ujs
//= require jquery-ui/jquery-ui-1.10.1.custom.min
//= require jquery-migrate
//= require bootstrap.min
//= require modernizr.min
//= require jquery.nicescroll
//= require slidebars.min
//= require switchery/switchery.min
//= require switchery/switchery-init
//= require flot-chart/jquery.flot
//= require flot-chart/flot-spline
//= require flot-chart/jquery.flot.resize
//= require flot-chart/jquery.flot.tooltip.min
//= require flot-chart/jquery.flot.pie
//= require flot-chart/jquery.flot.selection
//= require flot-chart/jquery.flot.stack
//= require flot-chart/jquery.flot.crosshair
//= require earning-chart-init
//= require sparkline/jquery.sparkline
//= require sparkline/sparkline-init
//= require data-table/js/jquery.dataTables.min
//= require data-table/js/dataTables.tableTools.min
//= require data-table/js/bootstrap-dataTable
//= require data-table/js/dataTables.colVis.min
//= require data-table/js/dataTables.responsive.min
//= require data-table/js/dataTables.scroller.min
//= require data-table-init
//= require jquery-easy-pie-chart/jquery.easy-pie-chart
//= require easy-pie-chart
//= require vector-map/jquery-jvectormap-1.2.2.min
//= require vector-map/jquery-jvectormap-world-mill-en
//= require dashboard-vmap-init
//= require icheck/skins/icheck.min
//= require todo-init
//= require jquery-countTo/jquery.countTo
//= require owl.carousel
//= require scripts
//= require jquery-editable.min.js
//= require angular.min

$(document).on('click', '[data-logout]', function(e) {
  e.preventDefault();
  $.post("/users/sign_out", { '_method': 'DELETE' }, function () {
    window.location = "/users/sign_in";
  });
});

function clearEnteries(form) {
	choice = confirm('Are you sure?');
	if(choice){
    document.getElementById(form).reset();
	}
}
