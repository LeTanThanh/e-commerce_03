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
