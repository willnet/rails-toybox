generate(:model, 'user name type')

rake('db:migrate')

create_file 'app/models/guest.rb' do
  <<~GUEST
    class Guest < User
    end
  GUEST
end

create_file 'app/models/member.rb' do
  <<~MEMBER
    class Member < User
    end
  MEMBER
end

create_file 'db/seeds.rb' do
  <<~SEED
    Guest.create!(name: 'guest')
    Member.create!(name: 'member')
  SEED
end

rake('db:seed')
