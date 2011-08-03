class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table "works", :force => true do |t|
      t.text    "title",                                                   :null => false
      t.text    "year",                 :limit => 255,                     :null => true
      t.integer "year_integer",         :limit => 2,                       :null => true
      t.text    "printer",                                                 :null => true
      t.text    "place_of_publication", :limit => 255,                     :null => true
      t.text    "citation",                                                :null => true
      t.text    "composed",             :limit => 255,                     :null => true
      t.text    "notes",                :limit => 16777215,                :null => true
      t.timestamps
    end
  
    add_index "works", ["year_integer"], :name => "YearSort"
  end

  def self.down
    drop_table :works
  end
end
