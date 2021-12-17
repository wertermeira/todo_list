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

    def statics_tasks(status)
      total = Task.where(status: status).count
      content_tag(:span, "#{pluralize(total, 'task')} in #{status}", class: class_btn_status(status))
    end
  end
end
