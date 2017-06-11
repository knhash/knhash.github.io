
function main() {

(function () {
  'use strict';

  /*====================================
  Navbar collapse
  ======================================*/
  // Hide nav on click
  $(".navbar-nav li a").click(function (event) {
    // check if window is small enough so dropdown is created
    var toggle = $(".navbar-toggle").is(":visible");
    if (toggle) {
      $(".navbar-collapse").collapse('hide');
    }
  });


}());


}
main();