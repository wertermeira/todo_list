FactoryBot.define do
  factory :todo_list do
    name { Faker::Lorem.sentence }
    status { 'active' }
  end
end
