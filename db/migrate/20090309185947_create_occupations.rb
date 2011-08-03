class CreateOccupations < ActiveRecord::Migration
  def self.up
    create_table "occupations", :force => true do |t|
      t.text "name", :limit => 255, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :occupations
  end
end
