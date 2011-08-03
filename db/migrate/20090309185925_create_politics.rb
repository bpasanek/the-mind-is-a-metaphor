class CreatePolitics < ActiveRecord::Migration
  def self.up
    create_table "politics", :force => true do |t|
      t.text "grouping", :limit => 255, :null => true
      t.text "name", :limit => 255, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :politics
  end
end
