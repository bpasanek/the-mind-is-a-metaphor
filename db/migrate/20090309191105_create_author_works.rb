class CreateAuthorWorks < ActiveRecord::Migration
  def self.up
    create_table "author_works", :force => true do |t|
      t.integer "author_id", :default => 0, :null => false
      t.integer "work_id",   :default => 0, :null => false
      t.timestamps
    end
    
    add_index :author_works, [:author_id, :work_id]
    add_index :author_works, [:work_id]
  end
  
  def self.down
    drop_table :author_works
  end
end
