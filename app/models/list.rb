class List < ApplicationRecord
  include RankedModel
  ranks :row_order

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { in: 2..20 }
end
