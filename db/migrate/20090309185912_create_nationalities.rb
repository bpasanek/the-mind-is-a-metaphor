class CreateNationalities < ActiveRecord::Migration
  def self.up
    create_table "nationalities", :force => true do |t|
      t.text "name", :limit => 255, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :nationalities
  end
end
