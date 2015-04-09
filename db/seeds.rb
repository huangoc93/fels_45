User.create!(username:  "admin",
             email:     "admin@framgia.com",
             password:              "admin",
             password_confirmation: "admin",
             name:  "Hua Viet Ngoc",
             admin: true,
             avatar: "/default/admin.png")
User.create!(username:  "ngoc",
             email:     "ngoc@framgia.com",
             password:              "12345",
             password_confirmation: "12345",
             name:  "ngockingspeed",
             avatar: "/default/user.png")

15.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = first_name.downcase + '_' + last_name.downcase
  email = "example-#{n+1}@framgia.com"
  password = "password"
  name = Faker::Name.prefix + ' ' + first_name + ' ' + last_name + ' ' + Faker::Name.suffix
  begin
    User.create!(username:  username,
                 email:     email,
                 password:              password,
                 password_confirmation: password,
                 name: name,
                 avatar: "/default/user.png")
  rescue Exception => e
  end
end

10.times do |n|
  name = Faker::Lorem.word
  description = ""
  5.times do 
    description += Faker::Lorem.sentence + " "
  end
  begin
    Category.create!(name: name, description: description, avatar: "/default/background.jpg")
  rescue Exception => e
  end  
end

Category.all.each do |category|
  30.times do |n|
    spell = Faker::Lorem.word + " " + Faker::Lorem.word
    begin
      Vocabulary.create!(spell: spell, category_id: category.id)
    rescue Exception => e
    end
  end
end