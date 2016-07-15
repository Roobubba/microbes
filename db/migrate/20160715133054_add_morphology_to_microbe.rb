class AddMorphologyToMicrobe < ActiveRecord::Migration
  def change
    add_column :microbes, :morphology, :string
  end
end
