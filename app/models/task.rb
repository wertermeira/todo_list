class Task < ApplicationRecord
  belongs_to :todo_list
  STATUSES = { todo: 0, doing: 1, done: 2 }.freeze
  validates :name, presence: true, length: { maximum: 200 }
  enum status: STATUSES, _prefix: :status
end
