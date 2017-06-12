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
    updateTotalPrice();
  });

  $('.btn-delete-product-in-cart').on('click', function() {
    var userId = $(this).data('user-id');
    var productId = $(this).data('product-id');
    var deleteProductInCartFlash = $(this).data('delete-product-in-cart-flash');
    var cart = Cookies.getJSON('cart');
    delete cart[userId][productId];

    if (Object.keys(cart[userId]).length == 0) {
      delete cart[userId]
    }
    if (Object.keys(cart).length == 0) {
      Cookies.remove('cart');
    } else {
      Cookies.set('cart', cart);
    }

    $('#product-in-cart-' + productId).slideUp();
    $('.count-product-in-cart').html(cartSize(userId));
    $('#flash').html(convertToHtmlString(deleteProductInCartFlash));
    updateTotalPrice();
  });

  $('.btn-order-now').on('click', function() {
    var userId = $(this).data('user-id');
    $.ajax({
      type: 'POST',
      url: '/orders',
      dataType: 'json',
      success: function(response) {
        $('#flash').html(response.html_flash);
        if (response.order_success) {
          var cart = Cookies.getJSON('cart');
          delete cart[userId];
          if (Object.keys(cart).length == 0) {
            Cookies.remove('cart');
          } else {
            Cookies.set('cart', cart);
          }
          $('.in-cart').slideUp();
          $('.count-product-in-cart').html(0);
          updateTotalPrice();
        }
      }
    });
  });

  function updateTotalPrice() {
    $.ajax({
      type: 'GET',
      url: '/orders',
      dataType: 'json',
      success: function(response) {
        $('.order-total-price').html(response.total_price);
      }
    });
  }
});
