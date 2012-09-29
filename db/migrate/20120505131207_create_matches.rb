class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.integer :doubanuser_id

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
