class CreateVoteRecords < ActiveRecord::Migration
  def change
    create_table :vote_records do |t|
      t.integer :user_id
      t.integer :venue_id
      t.boolean :is_yes

      t.timestamps
    end
  end
end
