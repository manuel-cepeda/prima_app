class RemoveLatLng < ActiveRecord::Migration
  def change
     remove_column :venues, :lat, :decimal, {:precision=>10, :scale=>6}
     remove_column :venues, :lng, :decimal, {:precision=>10, :scale=>6}     
  end
end
