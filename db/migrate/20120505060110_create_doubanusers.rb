class CreateDoubanusers < ActiveRecord::Migration
  def change
    create_table :doubanusers do |t|
      t.integer :id
      t.text :data
      t.string :gender

      t.timestamps
    end
  end
end
