class DropTableMmorphologys < ActiveRecord::Migration
  def self.up
    drop_table :morphologys
  end
end
