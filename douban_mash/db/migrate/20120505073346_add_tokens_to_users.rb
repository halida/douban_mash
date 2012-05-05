class AddTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_token, :string

    add_column :users, :douban_token, :string

  end
end
