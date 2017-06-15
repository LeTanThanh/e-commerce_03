$(document).ready(function(){
  addActiveClassToMenu();

  $(document).on('click','.btn-request-control', function () {
    btnRequestControlClick($(this));
  });

  $('.btn-search-user').on('click', function() {
    btnSearchUserClick();
  });
  
  $(document).on('click', '.btn-delete-user', function() {
    btnDeleteUserClick($(this));
  });

  $('.select-order-status').on('change', function() {
    selectOrderStatusChange($(this));
  });

  $('.btn-search-order-by-user').on('click', function() {
    searchOrdersByUserAndStatus();
  });

  $('.select-search-order-by-status').on('change', function() {
    searchOrdersByUserAndStatus();
  });

  $('.btn-add-new-category-in-modal').on('click', function() {
    btnAddNewCategoryInModalClick();
  });

  $('.btn-close-new-category-modal').on('click', function() {
    btnCloseNewCategoryModalClick();
  });

  $(document).on('click', '.btn-edit-category-in-modal', function() {
    btnEditCategoryInModal($(this));
  });

  $('.btn-close-edit-category-modal').on('click', function() {
    btnCloseEditCategoryModalClick();
  });

  $('.btn-search-category').on('click', function() {
    btnSearchCategoryClick();
  });

  $(document).on('click', '.btn-delete-category', function() {
    btnDeleteCategoryClick($(this));
  });
  
  $('.btn-search-product-by-name').on('click', function() {
    searchProductByNameAndCategoryId();
  });

  $('.select-search-product-by-category-id').on('change', function() {
    searchProductByNameAndCategoryId();
  });
  
  $('.btn-add-new-product-in-modal').on('click', function() {
    var name = $('.input-new-product-name').val();
    var categoryId = $('.select-new-product-category-id').val();
    var price = $('.input-new-product-price').val();
    var quantity = $('.input-new-product-quantity').val();
    var description = $('.textarea-new-product-description').val();
    var picture = $('.input-new-product-picture').val();
  });

  $('.input-new-product-picture').bind('change', function() {
    var fileName = this.files[0].name;
    var fileSize = this.files[0].size;
    var maxSize = $(this).data('max-size');
    $('.image-new-product-image').attr('src', "../assets/seed/product/" + fileName);
  })
});

function addActiveClassToMenu() {
  var menuIndex = -1;
  var path = window.location.pathname;

  if (path == '/admin/requests') {
    menuIndex = 0;
  } else if (path == '/admin/users') {
    menuIndex = 1;
  } else if (path == '/admin/categories') {
    menuIndex = 2;
  } else if (path == '/admin/products') {
    menuIndex = 3
  } else if (path == '/admin/orders') {
    menuIndex = 4;
  }

  if (menuIndex != -1) {
    $($('.vertical-menu').children().get(menuIndex)).addClass('active');
  }
}

function btnRequestControlClick(btn) {
  var page = btn.data('page');
  var requestCounter = btn.data('request-counter');
  var requestIndex = btn.data('request-index');
  var requestId = btn.data('request-id');
  var requestStatus = btn.data('request-status');
  var url = 'requests/' + requestId;
  $.ajax({
    type: 'POST',
    url: url,
    data: {
      page: page,
      request_counter: requestCounter,
      request_status: requestStatus
    },
    dataType: 'json',
    success: function(response){
      $('.request-container-' + requestIndex).replaceWith(response.html);
    }
  });
}

function btnSearchUserClick() {
  var input = $('.search-user-input').val();
  $.ajax({
    type: 'GET',
    url: '/admin/users',
    data: {
      input: input
    },
    dataType: 'json',
    success: function(response) {
      $('.user-table').html(response.html_user_table);
      $('.user-paginate').html(response.html_user_paginate);
    }
  });
}

function btnDeleteUserClick(btn) {
  var userId = btn.data('user-id');
  var page = btn.data('page');
  var perPage = btn.data('per-page');
  var input = btn.data('input');
  $.ajax({
    type: 'DELETE',
    url: '/admin/users',
    data: {
      user_id: userId,
      page: page,
      input: input
    },
    dataType: 'json',
    success: function(response) {
      $('#flash').html(response.html_flash);
      if (response.delete_user_success) {
        $('.user-table > tbody:last-child').append(response.html_user);
        $('.user-row-' + userId).remove();
        $('.user-no').each(function(index) {
          $(this).html((page - 1) * perPage + index + 1);
        })
      }
    }
  });
}

function selectOrderStatusChange(select) {
  var orderId = select.data('order-id');
  var currentStatus = select.data('current-status');
  var status = select.val();

  $.ajax({
    type: 'PATCH',
    url: '/admin/orders',
    data: {
      order_id: orderId,
      status: status
    },
    dataType: 'json',
    success: function(response) {
      $('#flash').html(response.html_flash);
      if (response.update_status_success) {
        select.data('current-status', status);
      }
      else {
        select.val(currentStatus);
      }
    }
  });
}

function searchOrdersByUserAndStatus() {
  var user = $('.search-order-by-user-input').val();
  var status = $('.select-search-order-by-status').val();
  
  $.ajax({
    type: 'GET',
    url: '/admin/orders',
    data: {
      user: user,
      status: status
    },
    dataType: 'json',
    success: function(response) {
      $('.order-table').html(response.html_order_table);
      $('.order-paginate').html(response.html_order_paginate);
    }
  });
}

function btnAddNewCategoryInModalClick() {
  var name = $('.input-new-category-name').val();

  $.ajax({
    type: 'POST',
    url: '/admin/categories',
    data: {
      name: name
    },
    dataType: 'json',
    success: function(response) {
      $('.create-new-category-flash').html(response.html_flash);
      if (response.create_category_success) {
        $('.create-new-category-errors').html('');
      }
      else {
        $('.create-new-category-errors').html(response.html_errors);
      }
    }
  });
}

function btnCloseNewCategoryModalClick() {
  $('.create-new-category-flash').html('');
  $('.create-new-category-errors').html('');
  $('.input-new-category-name').val('');
}

function btnEditCategoryInModal(btn) {
  var categoryId = btn.data('category-id');
  var categoryCounter = btn.data('category-counter');
  var page = btn.data('page');
  var name = $('.input-edit-category-name-' + categoryId).val();

  $.ajax({
    type: 'PATCH',
    url: '/admin/categories/' + categoryId,
    data: {
      name: name,
      category_counter: categoryCounter,
      page: page
    },
    dataType: 'json',
    success: function(response) {
      $('.update-category-flash').html(response.html_flash);
      if (response.update_category_success) {
        $('.update-category-errors').html('');
        $('.category-' + categoryId).replaceWith(response.html_category);
      }
      else {
        $('.update-category-errors').html(response.html_errors);
      }
    }
  });
}

function btnCloseEditCategoryModalClick() {
  $('.update-category-flash').html('');
  $('.update-category-errors').html('');
}

function btnSearchCategoryClick() {
  var input = $('.input-search-category').val();

  $.ajax({
    type: 'GET',
    url: '/admin/categories',
    data: {
      input: input
    },
    dataType: 'json',
    success: function(response) {
      $('.category-table-container').html(response.html_category_table);
      $('.category-paginate').html(response.html_category_paginate);
    }
  });
}

function btnDeleteCategoryClick(btn) {
  var categoryId = btn.data('category-id');
  var page = btn.data('page');
  var perPage = btn.data('per-page');
  var input = btn.data('input');

  $.ajax({
    type: 'DELETE',
    url: '/admin/categories/' + categoryId,
    data: {
      page: page,
      input: input
    },
    dataType: 'json',
    success: function(response) {
      $('#flash').html(response.html_flash);
      if (response.delete_category_success) {
        $('.category-table > tbody:last-child').append(response.html_category);
        $('.category-' + categoryId).remove();
        $('.category-no').each(function(index) {
          $(this).html((page - 1) * perPage + index + 1);
        })
      }
    }
  });
}

function searchProductByNameAndCategoryId() {
  var productName = $('.input-search-product-by-name').val();
  var categoryId = $('.select-search-product-by-category-id').val();

  $.ajax({
    type: 'GET',
    url: '/admin/products',
    data: {
      product_name: productName,
      category_id: categoryId
    },
    dataType: 'json',
    success: function(response) {
      $('.product-table-container').html(response.html_product_table_container);
      $('.product-paginate').html(response.html_product_paginate);
    }
  });
}