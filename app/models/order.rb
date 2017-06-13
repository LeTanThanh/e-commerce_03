class Order < ApplicationRecord
  enum order_status: [:inprogress, :sending, :done, :cancel]

  belongs_to :user
  has_many :order_details, dependent: :destroy

  scope :search, -> user, status do
    user_query = user.blank? ? "" : "users.name LIKE '%#{user}%'"
    status_query = (status.blank? || status == "-1") ? "" : "orders.status = #{status}"
    query_params = [user_query, status_query]
    query = ""

    query_params.each do |query_param|
      next if query_param.blank?
      if query.blank?
        query << query_param
      else
        query << " AND " << query_param
      end
    end

    joins("INNER JOIN users ON orders.user_id = users.id").where query
  end
end
