# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(id: 1, name: 'Jhon', bio: 'Test user', email: 'test@test.com',  password: 'abc123')
Post.create(id: 1, author: user, title: 'Post test', text: 'Testing...', comments_counter: 0, likes_counter: 0)
