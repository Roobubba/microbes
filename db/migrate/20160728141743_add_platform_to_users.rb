class AddPlatformToUsers < ActiveRecord::Migration
  def change
    add_column :users, :platform, :string, default: 'Windows'
  end
end
