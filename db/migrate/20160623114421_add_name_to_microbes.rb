class AddNameToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :name, :string
  end
end
