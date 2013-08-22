class AddTokenToSession < ActiveRecord::Migration
  def change
  	add_column :authorizations, :token, :string
  end
end
