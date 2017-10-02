generate(:model, 'user')
generate(:model, 'post')
generate(:model, 'bookmark user:references post:references')

rake('db:migrate')

insert_into_file 'app/models/user.rb', "has_many :bookmarked_posts, class_name: 'Post', source: :post, through: :bookmarks\n", after: "class User < ApplicationRecord\n"
insert_into_file 'app/models/user.rb', "has_many :bookmarks\n", after: "class User < ApplicationRecord\n"
insert_into_file 'app/models/post.rb', "has_many :bookmarked_users, class_name: 'User', source: :user, through: :bookmarks\n", after: "class Post < ApplicationRecord\n"
insert_into_file 'app/models/post.rb', "has_many :bookmarks\n", after: "class Post < ApplicationRecord\n"

create_file 'db/seeds.rb' do
  <<~SEED
    User.create!
    Post.create!
    Post.create!
  SEED
end

rake('db:seed')
