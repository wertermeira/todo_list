FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence }
    status { Task::STATUSES.keys.sample }
    todo_list { create(:todo_list) }
  end
end
