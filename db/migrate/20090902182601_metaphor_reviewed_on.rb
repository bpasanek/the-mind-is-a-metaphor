class MetaphorReviewedOn < ActiveRecord::Migration
  def self.up
    add_column :metaphors, :reviewed_on, :date
  end

  def self.down
    remove_column :metaphors, :reviewed_on
  end
end