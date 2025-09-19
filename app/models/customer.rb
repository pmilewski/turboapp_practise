class Customer < ApplicationRecord
  EDITABLE_ATTRS = [ :first_name, :last_name, :birthdate, :phone, :description ]

  validates :first_name, :last_name, :birthdate, :phone, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :birthdate, comparison: { less_than: Date.current }
end
