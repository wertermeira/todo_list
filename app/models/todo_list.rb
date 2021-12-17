class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy

  enum status: { active: 0, filed: 1 }, _prefix: :status

  scope :published, -> { where(status: :active) }

  validates :name, presence: true, length: { maximum: 200 }
end
