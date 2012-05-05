class AddGendersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string

    add_column :users, :select_gender, :string

  end
end
