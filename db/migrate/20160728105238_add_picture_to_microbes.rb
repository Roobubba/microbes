class AddPictureToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :picture, :string
  end
end
