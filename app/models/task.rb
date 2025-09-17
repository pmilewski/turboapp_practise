class Task < ApplicationRecord
  validates :name, presence: true, length: { in: 5..20 }
  validates :body, presence: true, length: { in: 10..50 }
end
