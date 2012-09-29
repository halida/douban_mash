class CreatePokereds < ActiveRecord::Migration
  def change
    create_table :pokereds do |t|
      t.integer :user_id
      t.integer :doubanuser_id

      t.timestamps
    end
  end
end
