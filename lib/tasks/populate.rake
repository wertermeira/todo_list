namespace :populate do
  include FactoryBot::Syntax::Methods if Rails.env.development?

  desc "Populate the database with test data"
  task todo_lists: :environment do
    create_list(:todo_list, 10).each do |todo_list|
      puts "Created TodoList: #{todo_list.name}"
      create_list(:task, rand(2..5), todo_list: todo_list).each do |task|
        puts "Created Task #{task.name} from TodoList: #{todo_list.name}"
      end
    end
  end
end
