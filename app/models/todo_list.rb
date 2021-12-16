class TodoList < ApplicationRecord
  enum status: { active: 0, filed: 1 }, _prefix: :status

  scope :published, -> { where(status: :active) }

  validates :name, presence: true
  validates :name, length: { maximum: 200 }
end
