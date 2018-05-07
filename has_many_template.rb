generate(:model, 'user name')
generate(:model, 'post title user:references')

rake('db:migrate')

insert_into_file 'app/models/user.rb', "has_many :posts\n", after: "class User < ApplicationRecord\n"
insert_into_file 'app/models/user.rb', "has_one :latest_post, -> { order(created_at: :desc) }, class_name: 'Post'\n", after: "class User < ApplicationRecord\n"
insert_into_file 'app/models/post.rb', "belongs_to :user\n", after: "class Post < ApplicationRecord\n"

create_file 'db/seeds.rb' do
  <<~SEED
    u = User.create!(name: 'willnet')
    u.posts.create!(title: 'willnet first post')
    u.posts.create!(title: 'willnet second post')
    u = User.create!(name: 'maeshima')
    u.posts.create!(title: 'maeshima first post')
    u.posts.create!(title: 'maeshima second post')
  SEED
end

rake('db:seed')
