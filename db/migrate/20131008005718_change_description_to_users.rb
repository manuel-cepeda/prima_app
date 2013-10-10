class ChangeDescriptionToUsers < ActiveRecord::Migration
  def change
	change_table :users do |t|
	  t.rename :description, :feedback
	end

  end
end
