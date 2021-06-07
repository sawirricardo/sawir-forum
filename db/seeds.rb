# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

%w[programming rails ruby javascript reactjs vuejs nodejs php laravel].each do |tag|
  Tag.create(name: tag)
end

(1..10).each do |_i|
  user = User.create(
    name: Faker::Internet.username,
    email: Faker::Internet.email,
    password: 'password',
    bio: Faker::Lorem.paragraph
  )

  (1..10).each do |_j|
    article = user.articles.create(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      body: Faker::Markdown.sandwich(sentences: 5)
    )

    article.tags << Tag.order(Arel.sql('RANDOM()')).take(3)
  end
end

Article.all.each do |article|
  (1..8).each do |_i|
    article.comments.create!(
      body: Faker::Lorem.paragraph,
      user_id: User.order(Arel.sql('RANDOM()')).first.id
    )
  end
end
