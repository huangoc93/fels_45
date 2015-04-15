User.create!(username:  "admin",
             email:     "admin@framgia.com",
             password:              "admin",
             password_confirmation: "admin",
             name:  "Hua Viet Ngoc",
             admin: true)
User.create!(username:  "ngoc",
             email:     "ngoc@framgia.com",
             password:              "12345",
             password_confirmation: "12345",
             name:  "ngockingspeed")

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
                 name: name)
  rescue Exception => e
  end
end

6.times do |n|
  name = Faker::Lorem.word
  description = ""
  5.times do 
    description += Faker::Lorem.sentence + " "
  end
  begin
    Category.create!(name: name, description: description)
  rescue Exception => e
  end  
end

Category.all.each do |category|
  60.times do |n|
    name = Faker::Lorem.word + " " + Faker::Lorem.word
    begin
      Word.create!(name: name, category_id: category.id)
    rescue Exception => e
    end
  end
end

Word.all.each do |word|
  Answer.create!(content: Faker::Lorem.word + " " + Faker::Lorem.word,
                 correct: true, word_id: word.id)
  3.times do 
    Answer.create!(content: Faker::Lorem.word + " " + Faker::Lorem.word,
                   correct: false, word_id: word.id)
  end
end

user_ngoc = User.find_by_username "ngoc"
User.all.each do |user|
  unless user_ngoc.id == user.id
    user.id < 10 ? user_ngoc.follow(user) : user.follow(user_ngoc)
  end
  10.times do
    Activity.create!(description: Faker::Lorem.sentence,
                     user_id: user.id)
  end
end

Category.all.each do |category|
  lesson = Lesson.create!(user_id: user_ngoc.id,
                          category_id: category.id)
  category.words.each.with_index do |word, index|
    break if index >= 10
    LessonWord.create!(lesson_id: lesson.id,
                       word_id: word.id,
                       correct: true)
  end
end