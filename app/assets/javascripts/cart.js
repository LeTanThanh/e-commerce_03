$(document).ready(function(){
  $('.btn-update-product-quantity').on('click', function() {
    var userId = $(this).data('user-id');
    var productId = $(this).data('product-id');
    var productQuantity = $('.product-quantity-' + productId).val();
    var updateProductQuantityFlash = $(this).data('update-product-quantity-flash');
    var cart = Cookies.getJSON('cart');
    cart[userId][productId] = productQuantity;
    Cookies.set('cart', cart);
    $.ajax({
      type: 'GET',
      url: '/order_details/show',
      data: {
        product_id: productId,
        quantity: productQuantity
      },
      dataType: 'json',
      success: function(response) {
        $('#product-status-' + productId).html(response.product_status);
      }
    });
    $('#flash').html(convertToHtmlString(updateProductQuantityFlash));
  });
});
