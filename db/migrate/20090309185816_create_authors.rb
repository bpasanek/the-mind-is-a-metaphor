class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table "authors", :force => true do |t|
      t.text    "name",           :limit => 255,                     :null => false
      t.text    "last_name",      :limit => 255,                     :null => true
      t.text    "first_name",     :limit => 255,                     :null => true
      t.string  "gender",                        :default => "Male", :null => false
      t.text    "date_of_birth",  :limit => 255,                     :null => true
      t.text    "date_of_death",  :limit => 255,                     :null => true
      t.integer "occupation_id"#,  :default => 0,      :null => false
      t.integer "religion_id"#,    :default => 0,      :null => false
      t.integer "politic_id"#,    :default => 0,      :null => false
      t.integer "nationality_id"#, :default => 0,      :null => false
      t.text    "notes",                                             :null => true
      t.timestamps
    end
    #add_index "authors", ["religion_id"], :name => "ReligionID"
    #add_index "authors", ["politic_id"], :name => "PoliticID"
    #add_index "authors", ["occupation_id"], :name => "OccupationID"
    #add_index "authors", ["nationality_id"], :name => "NationalityID"
  end

  def self.down
    drop_table :authors
  end
end