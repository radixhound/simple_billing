class AddStripeCardTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_card_token,  :string
    add_column :users, :stripe_card_type,   :string
    add_column :users, :stripe_card_digits, :string
    add_column :users, :stripe_card_expiry, :string
  end
end
