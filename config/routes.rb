Rails.application.routes.draw do
  root 'todo_lists#index'
  resources :todo_lists do
    resources :tasks, only: %i[new create edit update destroy], module: :todo_lists do
      member do
        put 'status_update/:status', to: 'tasks#status_update', as: :status_update
      end
    end
  end
end
