class AddFigerprintsToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :attachment_fingerprint, :string
    add_column :microbes, :androidattachment_fingerprint, :string
  end
end
