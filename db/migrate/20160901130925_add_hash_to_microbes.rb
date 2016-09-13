class AddHashToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :hash, :string
  end
end
