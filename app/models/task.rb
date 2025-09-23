class Task < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :list_id


  belongs_to :list

  validates :name, presence: true, length: { in: 5..20 }
  validates :body, presence: true, length: { in: 10..50 }
end
