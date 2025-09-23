class List < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, length: { in: 2..20 }
end
