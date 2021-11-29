User.create!(name: "Ashik Varghese",
             email: "ashik.varghese@hotmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

#generate sample microposts using Faker
users = User.order(:created_at).take(6)
50.times do
  content = Faker::ChuckNorris.fact
  users.each { |user| user.microposts.create!(content: content) }
end

#generate sample relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }