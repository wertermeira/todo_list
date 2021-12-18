module TodoLists
  module TasksHelper
    def class_btn_status(status)
      class_btn = {
        'done' => 'btn-success',
        'doing' => 'btn-warning',
        'todo' => 'btn-danger'
      }
      "btn btn-sm #{class_btn[status.to_s]}"
    end

    def statics_tasks(todo_list: nil, status:)
      tasks = if todo_list.present?
                todo_list.tasks
              else
                Task
              end
      total = tasks.where(status: status).count
      content_tag(:span, "#{pluralize(total, 'task')} in #{status}", class: class_btn_status(status))
    end
  end
end
