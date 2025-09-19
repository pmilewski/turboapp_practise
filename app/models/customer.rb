class Customer < ApplicationRecord
  EDITABLE_ATTRS = [ :first_name, :last_name, :birthdate, :phone, :description ]

  validates :first_name, :last_name, :birthdate, :phone, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :birthdate, comparison: { less_than: Date.current }


  def self.ransackable_attributes(auth_object = nil)
    [ "first_name", "last_name", "description" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
