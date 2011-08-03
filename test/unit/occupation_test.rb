require 'test_helper'

class OccupationTest < ActiveSupport::TestCase
  fixtures :occupations
  
  # Don't allow a completely empty record
  def test_no_occupation_fails
    empty = Occupation.new
    assert !empty.valid?
    assert empty.errors.invalid?(:name)
  end
  
  # Make sure that the occupation doesn't contain invalid characters
  def test_invalid_occupation_value
    occupation_obj = Occupation.new(:name => 'Writer > Soldier')
    assert !occupation_obj.valid?
    assert occupation_obj.errors.invalid?(:name)
  end
  
  # Occupation must be unique - second occurrence of poet should fail
  def test_duplicate_occupation_value
    occupation_obj = Occupation.new(:name => 'poet')
    assert !occupation_obj.valid?
    assert occupation_obj.errors.invalid?(:name)
  end
  
  # Check that update is possible
  def test_occupation_only_update
    occupation_obj = Occupation.find_by_name(occupations(:poet).name)
    occupation_obj.name = "Translator"
    assert occupation_obj.save
  end
  
  # Confirm a new record will save
  def test_new_record_saves
    occupation_obj = Occupation.new(:name => "Poet, Playwright, Critic")
    assert occupation_obj.save
  end
end