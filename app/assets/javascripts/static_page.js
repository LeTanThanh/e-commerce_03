$(document).ready(function(){
  var products = $('.hot-trend-product');
  var currentStartIndex = 0;
  var maxIndex = 10;

  $('.hot-trend-product.hide-init').hide();

  $('#pre-product').on('click', function () {
    var startIndex = currentStartIndex - 1;
    if (startIndex >= 0) {
      var endIndex = startIndex + 3;
      $(products.get(startIndex)).show();
      $(products.get(endIndex + 1)).hide();
      currentStartIndex = currentStartIndex - 1;
    }
  });

  $('#next-product').on('click', function () {
    var startIndex = currentStartIndex + 1;
    if (startIndex <= maxIndex - 4 ) {
      var endIndex = startIndex + 3;
      $(products.get(startIndex - 1)).hide();
      $(products.get(endIndex)).show();
      currentStartIndex = currentStartIndex + 1
    }
  });
});
