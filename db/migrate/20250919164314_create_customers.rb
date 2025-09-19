class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :phone
      t.string :description

      t.timestamps
    end
  end
end
