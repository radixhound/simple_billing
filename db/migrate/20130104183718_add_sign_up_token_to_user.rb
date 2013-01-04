class AddSignUpTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :signup_token, :string
  end
end
