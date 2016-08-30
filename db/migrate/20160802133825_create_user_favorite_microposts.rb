class CreateUserFavoriteMicroposts < ActiveRecord::Migration
  def change
    create_table :user_favorite_microposts do |t|
      t.references :user, index: true
      t.references :micropost, index: true

      t.timestamps null: false
    end
  end
end
