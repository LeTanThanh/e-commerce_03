module ApplicationHelper
  def get_title page_title = ""
    app_title = t ".app_title"
    page_title.blank? ? app_title : page_title << " | " << app_title
  end
end
