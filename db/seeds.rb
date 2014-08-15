require 'faker'

# Create Users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation! # Keeps the app from sending confirmation to take addresses
  user.save
end
users = User.all

# create posts
50.times do
  Post.create(
    user:  users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end
posts = Post.all

# create comments

100.times do
	Comment.create(
    # user: users.sample, # uncomment when Users are associated with Comments
		post: posts.sample,
		body: Faker::Lorem.paragraph
	)
end

# Updates first account with my info so I don't have to
# create a account every time I seed new data.
User.first.update_attributes(
  email: '120photo@gmail.com',
  password: 'password',
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"