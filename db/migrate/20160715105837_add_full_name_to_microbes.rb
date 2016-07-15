class AddFullNameToMicrobes < ActiveRecord::Migration
  def change
    add_column :microbes, :fullname, :string
  end
end
