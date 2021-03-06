# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Category.count.zero?
  [
    'Rock',
    'TED Talks',
    'Pop',
    'Hard Rock',
    'TV Show',
    'Movie Scene',
    'Documentary',
    'Metal',
    'Other',
  ].each do |name|
    Category.create(name: name)
  end
end

if Level.count.zero?
  ['easy', 'medium', 'hard'].each do |name|
    Level.create(name: name)
  end
end

if User.count.zero?
  User.create(:email => 'test@test.com', password: '', native_language: 'pl', admin: true)
end
