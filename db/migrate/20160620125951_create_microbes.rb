class CreateMicrobes < ActiveRecord::Migration
  def change
    create_table :microbes do |t|
      t.string :assetbundle
      t.string :assetbundle_fingerprint
      t.string :assetname
      t.string :link
    end
  end
end
