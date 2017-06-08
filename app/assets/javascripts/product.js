$(document).ready(function(){
  var newCommentMessage = $('.new-comment-message');
  var btnSendComment = $('.btn-send-comment');
  var userRatingPoint = $('#user_rating_point');
  var btnSendRating = $('#btn-send-rating')
  var btnAddToCart = $('.btn-add-to-cart');

  reloadCountProductInCart();

  btnSendComment.on('click', function () {
    var productId = btnSendComment.data('product-id');
    var message = newCommentMessage.val();
    var url = '/comments';

    $.ajax({
      type: 'POST',
      url: url,
      data: {
        product_id: productId,
        message: message,
      },
      dataType: 'json',
      success: function(response) {
        if(response.save_success) {
          newCommentMessage.val('');
          $('.list-comment').prepend(response.html_comment);
        }
        else {
          $('#flash').html(response.html_flash);
        }
      }
    });
  });

  btnSendRating.on('click', function () {
    var productId = btnSendRating.data('product-id');
    var ratingPoint = userRatingPoint.val();
    var userRated = btnSendRating.data('user-rated');
    var ratingId = btnSendRating.data('rating-id');

    if (userRated) {
      $.ajax({
        type: 'PATCH',
        url: '/ratings/' + ratingId,
        data: {
          product_id: productId,
          rating_point: ratingPoint,
          rating_id: ratingId
        },
        dataType: 'json',
        success: function(response) {
          updateRatingView(response);
        }
      });
    }
    else {
      $.ajax({
        type: 'POST',
        url: '/ratings',
        data: {
          product_id: productId,
          rating_point: ratingPoint
        },
        dataType: 'json',
        success: function(response){
          updateRatingView(response);
        }
      });
    }
  });

  btnAddToCart.on('click', function(){
    var userId = btnAddToCart.data('user-id');
    var productId = btnAddToCart.data('product-id');
    var maxCartSize = btnAddToCart.data('max-cart-size');
    var fullCartFlash = btnAddToCart.data('full-cart-flash');
    var inCartFlash = btnAddToCart.data('in-cart-flash');
    var addToCartFlash = btnAddToCart.data('add-to-cart-flash');
    var size = cartSize(userId);
    var cart = Cookies.getJSON("cart");

    if (size >= maxCartSize) {
      $('#flash').html(convertToHtmlString(fullCartFlash));
      return
    }

    if (cart) {
      if (cart[userId]) {
        if (cart[userId][productId]) {
          $('#flash').html(convertToHtmlString(inCartFlash));
          return
        }
        else {
          cart[userId][productId] = 1;
          $('#flash').html(convertToHtmlString(addToCartFlash));
        }
      }
    }
    else {
      cart = {};
      cart[userId] = {};
      cart[userId][productId] = 1;
      $('#flash').html(convertToHtmlString(addToCartFlash));
    }

    Cookies.set("cart", cart);
    size = cartSize(userId);
    $('.count-product-in-cart').html(size);
  });

  function updateRatingView(response) {
    $('#flash').html(response.html_flash);
    if(response.save_success) {
      $('#rating-point').html(response.html_rating_poin);
      btnSendRating.data('user-rated', true);
    }
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

  function convertToHtmlString(str) {
    str = str.replace(/&lt;/g, '<');
    str = str.replace(/&gt;/g, '>');
    str = str.replace(/&quot;/g, '"');
    return str
  }
  
  function reloadCountProductInCart() {
    var userInfo = $('.user-info');
    var countProductInCart = 0;

    if (userInfo) {
      var userId = userInfo.data('user-id');
      countProductInCart = cartSize(userId);
    }
    $('.count-product-in-cart').html(countProductInCart);
  }
});
