class CreateMetaphors < ActiveRecord::Migration
  def self.up
    create_table "metaphors", :force => true do |t|
      t.integer "work_id"#,         :default => 0,                :null => false
      t.text    "metaphor",        :unique => true,              :null => false
      t.text    "text",                                          :null => true
#      t.text    "category",        :limit => 255,                :null => true
#      t.text    "subcategory",     :limit => 255,                :null => true
      t.text    "context",                                       :null => true
      t.text    "provenance",                                    :null => true
      # date of entry
      t.datetime    :created_at,        :null => false
      # date of review
      t.datetime    :updated_at,  :default => '0000-00-00 00:00:00',  :null => true
#      t.text    "sub_subcategory", :limit => 255,                :null => true
#      t.text    "type",            :limit => 255,                :null => true
      t.text    "theme",           :limit => 255,                :null => true
      t.text    "comments",                                      :null => true
      t.text    "dictionary",      :limit => 255,                :null => true
      t.timestamps
    end
  
    #add_index "metaphors", ["work_id"], :name => "WorkID"
    
  end

  def self.down
    drop_table :metaphors
  end
end