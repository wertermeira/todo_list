class TodoList < ApplicationRecord
  enum status: %i[active filed], _prefix: :status

  validates :name, presence: true
  validates :name, length: { maximum: 200 }
end
