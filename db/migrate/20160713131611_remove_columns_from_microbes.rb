class RemoveColumnsFromMicrobes < ActiveRecord::Migration
  def change
    remove_column :microbes, :assetbundle
    remove_column :microbes, :assetbundle_fingerprint
    remove_column :microbes, :assetname
  end
end
