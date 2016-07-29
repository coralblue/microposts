class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :strings
  end
end
