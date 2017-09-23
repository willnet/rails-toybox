generate(:model, 'article')
generate(:model, 'event')
generate(:model, 'comment commentable:references{polymorphic}:index')

rake('db:migrate')

insert_into_file 'app/models/article.rb', "has_many :comments, as: :commentable\n", after: "class Article < ApplicationRecord\n"
insert_into_file 'app/models/event.rb', "has_many :comments, as: :commentable\n", after: "class Event < ApplicationRecord\n"

create_file 'db/seeds.rb' do
  <<~SEED
    article = Article.create!
    article.comments.create!
    event = Event.create!
    event.comments.create!
  SEED
end

rake('db:seed')
