class AddCurrencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currency, :integer
  end
end
