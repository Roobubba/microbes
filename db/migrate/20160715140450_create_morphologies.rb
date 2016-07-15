class CreateMorphologies < ActiveRecord::Migration
  def change
    create_table :morphologies do |t|
      t.string :morphology
    end
  end
end
