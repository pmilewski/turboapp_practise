class AddAccessAndPasscodeToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :access, :integer, default: 0, null: false
    add_column :posts, :passcode, :string
  end
end
