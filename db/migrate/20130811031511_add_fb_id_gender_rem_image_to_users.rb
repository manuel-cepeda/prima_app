class AddFbIdGenderRemImageToUsers < ActiveRecord::Migration

  def up
    add_column :users, :fb_id, :string
    add_column :users, :gender, :string
  end

end
