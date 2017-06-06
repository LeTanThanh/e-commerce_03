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
      created_at: FFaker::Time.datetime
  end
end

5.times do
  Category.create! name: FFaker::Product::brand
end

categories = Category.all
categories.each do |category|
  20.times do
    name = FFaker::Product.product
    price = 1000 * (rand(50) + 50)
    quantity = (rand(10) + 10)
    picture = File.open(File.join Rails.root,
      "/app/assets/images/seed/product/#{rand 10}.jpg")
    description = FFaker::Lorem.paragraph
    category.products.create! name: name, price: price, picture: picture,
      quantity: quantity, description: description
  end
end

users.each do |user|
  3.times do
    user.orders.create! total_price: 0
  end
end

orders = Order.all
orders.each do |order|
  total_price = 0
  products = []
  products << Product.find(10  +rand(10))
  products << Product.find(20 + rand(10))
  products << Product.find(30 + rand(10))
  products.each do |product|
    price = product.price
    quantity = 1 + rand(3)
    total_price += price * quantity
    order.order_details.create! order: order, product: product,
      price: price, quantity: quantity
  end
  order.update_attributes total_price: total_price
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
