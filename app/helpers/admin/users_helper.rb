module Admin::UsersHelper
  def search_user_input_value params_input
    params_input ? params_input : ""
  end
end
