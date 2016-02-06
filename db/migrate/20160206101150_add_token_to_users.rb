class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_token, :string, limit: 100, after: :admin
  end
end
