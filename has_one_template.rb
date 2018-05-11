generate(:model, 'user name')
generate(:model, 'user_token token user:references')

rake('db:migrate')

insert_into_file 'app/models/user.rb', "has_one :user_token\n", after: "class User < ApplicationRecord\n"
insert_into_file 'app/models/user_token.rb', "belongs_to :user\n", after: "class UserToken < ApplicationRecord\n"
insert_into_file 'app/models/user_token.rb', "validates :token, presence: true, uniqueness: true\n", after: "belongs_to :user\n"

create_file 'db/seeds.rb' do
  <<~SEED
    u = User.create!(name: 'willnet')
    u.create_user_token(token: 'token')
  SEED
end

rake('db:seed')
