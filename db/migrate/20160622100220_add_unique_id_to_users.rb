class AddUniqueIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uniqueid, :string
  end
end
