require 'test_helper'

class ReligionTest < ActiveSupport::TestCase
  fixtures :religions
  
  # Don't allow a completely empty record
  def test_no_religion_fails
    empty = Religion.new
    assert !empty.valid?
    assert empty.errors.invalid?(:name)
  end
  
  # Make sure that the religion doesn't contain invalid characters
  def test_invalid_religion_value
    religion_obj = Religion.new(:name => 'Catholicism > Roman Catholic')
    assert !religion_obj.valid?
    assert religion_obj.errors.invalid?(:name)
  end
  
  # Check that the grouping field contains acceptable characters
  def test_invalid_grouping_value
    religion_obj = Religion.new(:grouping => 'Religious < Philosophy', :name => 'Freethinker')
    assert !religion_obj.valid?
    assert religion_obj.errors.invalid?(:grouping)
  end
  
  # A grouping without a religion value should fail
  def test_grouping_without_religion
    religion_obj = Religion.new(:grouping => 'All Anglican')
    assert !religion_obj.valid?
    assert religion_obj.errors.invalid?(:name)
  end
  
  # Religion must be unique - second occurrence of roman catholic should fail
  def test_duplicate_religion_value
    religion_obj = Religion.new(:name => 'Roman Catholic')
    assert !religion_obj.valid?
    assert religion_obj.errors.invalid?(:name)
  end
  
  # Check that update is possible
  def test_religion_only_update
    religion_obj = Religion.find_by_name(religions(:protestant).name)
    religion_obj.grouping = "Religious Philosophy"
    religion_obj.name = "Freethinker"
    assert religion_obj.save
  end
  
  # Confirm grouping not needed on record modification
  def test_grouping_and_religion_valid
    religion_obj = Religion.find_by_id(religions(:catholicism).id)
    religion_obj.grouping = ""
    assert religion_obj.save
  end
  
  # Confirm a new record will save
  def test_new_record_saves
    religion_obj = Religion.new(:name => "Early Christion")
    assert religion_obj.save
  end
  
  def test_metaphors
    r = religions(:catholicism)
    assert_equal Array, r.metaphors.class
    assert_equal 0, r.metaphors.size
  end
  
end