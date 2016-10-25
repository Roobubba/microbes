class AddInfoToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :gram_status, :string
    add_column :microbes, :number_genes, :string
    add_column :microbes, :pathogenic, :string
    add_column :microbes, :dimensions, :string
  end
end
