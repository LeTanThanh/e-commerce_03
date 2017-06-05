module Admin::RequestsHelper
  def cal_request_page_index page
    params[:page] ? params[:page].to_i : page
  end

  def cal_request_index page_index, request_counter
    (page_index - 1) * Settings.will_paginate.per_page + request_counter
  end

  def load_request_controls
    {
      waiting: {
        btn_class: "btn-default",
        glyphicon_class: "glyphicon-pause"
      },
      accept: {
        btn_class: "btn-success",
        glyphicon_class: "glyphicon-ok-circle"
      },
      reject: {
        btn_class: "btn-danger",
        glyphicon_class: "glyphicon-ban-circle"
      }
    }
  end
end
