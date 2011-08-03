class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.integer "metaphor_id",  :null => true
      t.text "name", :limit => 255, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :types
  end
end
