class AddLatitudeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :decimal
  end
end
