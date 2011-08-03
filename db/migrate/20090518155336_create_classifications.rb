class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.text :value
      t.string :classifiable_type
      t.integer :classifiable_id
      t.timestamps
    end
    
    add_index :classifications, [:classifiable_id]
    
  end

  def self.down
    drop_table :classifications
  end
end