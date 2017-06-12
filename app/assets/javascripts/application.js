//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cookie
//= require_tree .

function convertToHtmlString(str) {
  str = str.replace(/&lt;/g, '<');
  str = str.replace(/&gt;/g, '>');
  str = str.replace(/&quot;/g, '"');
  return str;
}
