class RemoveFeedbackToUsers < ActiveRecord::Migration
  def change
	change_table :users do |t|
	  t.remove :feedback
	end

  end
end
