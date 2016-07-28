class AddAttachmentToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :attachment, :string
  end
end
