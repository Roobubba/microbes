class AddAndroidattachmentToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :androidattachment, :string
  end
end
