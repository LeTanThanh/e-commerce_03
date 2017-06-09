//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cookie
//= require_tree .

function convertToHtmlString(str) {
  str = str.replace(/&lt;/g, '<');
  str = str.replace(/&gt;/g, '>');
  str = str.replace(/&quot;/g, '"');
  return str
}

function cartSize(userId) {
  var cart = Cookies.getJSON("cart");
  if (cart){
    var cartUser = cart[userId];
    if (cartUser) {
      return Object.keys(cartUser).length;
    }
    return 0;
  }
  return 0;
}
