class RemoveMorphologyFromMicrobes < ActiveRecord::Migration
  def change
    remove_column :microbes, :morphology
    add_column :microbes, :morphology_id, :integer
  end
end
