Fabricator(:user) do
  email { sequence(:email) { |i| "user-#{Time.now.to_f}-#{i}@example.com" } }
  password { Faker::Internet.password(8) }
  first_name Faker::Name.first_name
  last_name Faker::Name.last_name
end

Fabricator(:admin, from: :user) do
  before_create  { |user, transients| user.add_role :admin }
end