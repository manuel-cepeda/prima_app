class AddImageToUsers < ActiveRecord::Migration
  def up
    add_column :users, :image, :string
  end
end
