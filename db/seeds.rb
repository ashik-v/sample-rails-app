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