class AddCostToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :cost, :integer
  end
end
