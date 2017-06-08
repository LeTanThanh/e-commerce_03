$(document).ready(function(){
  var menuIndex = 0;
  var path = window.location.pathname;

  if (path == '/cart') {
    menuIndex = 2;
  } else if (path == '/requests') {
    menuIndex = 4;
  }
  else {
    var parameters = path.split('/');
    if (parameters[1] == 'users') {
      if (parameters.length == 3) {
        menuIndex = 0;
      } else if (parameters.length == 4) {
        menuIndex = 1
      }
    }
  }
  $($('.vertical-menu').children().get(menuIndex)).addClass('active');
});
