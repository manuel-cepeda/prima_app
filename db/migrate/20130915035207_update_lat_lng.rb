class UpdateLatLng < ActiveRecord::Migration
  def change
	remove_column :venue, :lat
	remove_column :venue, :lng
  end
end
