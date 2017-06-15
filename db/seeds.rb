require "ffaker"

User.create! name: "EcomAdmin", email: "ecom-admin@ecom.com", is_admin: true,
  password: "ecom-admin", password_confirmation: "ecom-admin"

20.times do |i|
  User.create! email: "ecom-user-#{i + 1}@ecom.com", name: FFaker::Name.name,
    password: "ecom-user-#{i + 1}", password_confirmation: "ecom-user-#{i + 1}"
end

users = User.all
users.each do |user|
  5.times do
    user.requests.create! content: FFaker::Lorem.paragraph, status: rand(3),
      created_at: FFaker::Time.between(2.years.ago, Time.now)
  end
end

20.times do
  date_time = FFaker::Time.between(2.years.ago, Time.now)
  Category.create! name: FFaker::Product::brand, created_at: date_time,
    updated_at: date_time
end

categories = Category.all
categories.each do |category|
  (10 + rand(10)).times do
    name = FFaker::Product.product
    price = 1000 * (rand(50) + 50)
    quantity = (rand(10) + 10)
    picture = File.open(File.join Rails.root,
      "/app/assets/images/seed/product/#{rand 10}.jpg")
    description = FFaker::Lorem.paragraph
    created_at = FFaker::Time.between(2.years.ago, Time.now)
    category.products.create! name: name, price: price, picture: picture,
      quantity: quantity, description: description, created_at: created_at
  end
end

users.each do |user|
  3.times do
    user.orders.create! created_at: FFaker::Time.between(2.years.ago, Time.now),
      status: rand(4)
  end
end

orders = Order.all
orders.each do |order|
  products = []
  products << Product.find(10  +rand(10))
  products << Product.find(20 + rand(10))
  products << Product.find(30 + rand(10))
  products.each do |product|
    price = product.price
    quantity = 1 + rand(3)
    order.order_details.create! order: order, product: product,
      price: price, quantity: quantity
  end
end

products = Product.all
products.each do |product|
  users = []
  users << User.find(5 + rand(5))
  users << User.find(10 + rand(5))
  users << User.find(15 + rand(5))
  users.each do |user|
    user.comments.create! product: product, message: FFaker::Lorem.paragraph,
      created_at: FFaker::Time.datetime
  end
end

products.each do |product|
  users = []
  users << User.find(5 + rand(5))
  users << User.find(10 + rand(5))
  users << User.find(15 + rand(5))
  total_rating_point = 0
  users.each do |user|
    user_rating_point = rand 11
    total_rating_point += user_rating_point
    user.ratings.create! product: product, rating_point: user_rating_point
  end
  product.update_attributes rating_point: (total_rating_point / 3.0).round(2)
end
