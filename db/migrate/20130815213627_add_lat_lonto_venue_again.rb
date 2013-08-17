class AddLatLontoVenueAgain < ActiveRecord::Migration
  def self.up
   change_column :venues, :lat, :decimal, {:precision=>10, :scale=>6}
   change_column :venues, :lng, :decimal, {:precision=>10, :scale=>6}
  end

  def self.down
   change_column :venues, :lat, :string
   change_column :venues, :lng, :string
  end
end

