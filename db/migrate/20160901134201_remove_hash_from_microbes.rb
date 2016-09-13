class RemoveHashFromMicrobes < ActiveRecord::Migration
  def change
    remove_column :microbes, :hash
    add_column :microbes, :microbe_hash, :string
  end
end
