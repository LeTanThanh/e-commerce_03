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
});

function addActiveClassToMenu() {
  var menuIndex = -1;
  var path = window.location.pathname;

  if (path == '/admin/requests') {
    menuIndex = 0;
  } else if (path == '/admin/users') {
    menuIndex = 1;
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
        $('.user-row-' + userId).remove();
        $('.user-table > tbody:last-child').append(response.html_user);
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
