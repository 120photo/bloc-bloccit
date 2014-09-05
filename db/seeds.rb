require 'faker'

# Create Users
15.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation! # Keeps the app from sending confirmation to take addresses
  user.save
end
users = User.all


# create topics
25.times do
  Topic.create(
    name:  Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
end
topics = Topic.all


# create posts
500.times do
  post = Post.create(
    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )

  post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  post.create_vote
  post.update_rank
end
posts = Post.all

# create comments

2000.times do
	Comment.create(
    user: users.sample, # uncomment when Users are associated with Comments
		post: posts.sample,
		body: Faker::Lorem.paragraph
	)
end

# # Updates first account with my info so I don't have to
# # create a account every time I seed new data.
# User.first.update_attributes(
#   email: '120photo@gmail.com',
#   password: 'password',
# )

# create admin user
admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)
admin.skip_confirmation!
admin.save

# create moderator
moderator = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'password',
  role: 'moderator'
)
moderator.skip_confirmation!
moderator.save

# create a member
member = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'password',
)
member.skip_confirmation!
member.save


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"
