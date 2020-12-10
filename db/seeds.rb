# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(username: 'abcd', email: 'a@example.com', password: 'password')
user2 = User.create!(username: 'jsmith', email: 'jsmith@example.com', password: 'password')
user3 = User.create!(username: 'tphill', email: 'tphill@example.com', password: 'password')
user4 = User.create!(username: 'crichards', email: 'crichards@example.com', password: 'password')

Friendship.create!(user_id: user1.id, friend_id: user2.id)
Friendship.create!(user_id: user1.id, friend_id: user3.id)
Friendship.create!(user_id: user1.id, friend_id: user4.id)
