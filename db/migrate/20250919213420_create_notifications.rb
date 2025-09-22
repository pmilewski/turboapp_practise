class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
