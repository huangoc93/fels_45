User.create!(username:  "admin",
             email:     "admin@framgia.com",
             password:              "admin",
             password_confirmation: "admin",
             name:  "Hua Viet Ngoc",
             admin: true)

15.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = first_name.downcase + '_' + last_name.downcase
  email = "example-#{n+1}@framgia.com"
  password = "password"
  name = Faker::Name.prefix + ' ' + first_name + ' ' + last_name + ' ' + Faker::Name.suffix
  User.create!(username:  username,
               email:     email,
               password:              password,
               password_confirmation: password,
               name: name)
end