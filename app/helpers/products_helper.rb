module ProductsHelper
  def rating_point_options
    options = []
    11.times do |i|
      options << [pluralize(i, I18n.t("products.show.points")), i]
    end
    options
  end
end
