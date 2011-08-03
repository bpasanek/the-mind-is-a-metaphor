require 'test_helper'

class PoliticTest < ActiveSupport::TestCase
  fixtures :politics
  
  # Don't allow a completely empty record
  def test_no_politic_fails
    empty = Politic.new
    assert !empty.valid?
    assert empty.errors.invalid?(:name)
  end
  
  # Make sure that the religion doesn't contain invalid characters
  def test_invalid_politic_value
    politic_obj = Politic.new(:name => 'Liberty Party > Free Soil Party')
    assert !politic_obj.valid?
    assert politic_obj.errors.invalid?(:name)
  end
  
  # Check that the grouping field contains acceptable characters
  def test_invalid_grouping_value
    politic_obj = Politic.new(:grouping => 'Tory < Royalist', :name => 'Tory')
    assert !politic_obj.valid?
    assert politic_obj.errors.invalid?(:grouping)
  end
  
  # A grouping without a religion value should fail
  def test_grouping_without_religion
    politic_obj = Politic.new(:grouping => 'Opposition')
    assert !politic_obj.valid?
    assert politic_obj.errors.invalid?(:name)
  end
  
  # Politic must be unique - second occurrence of Whig should fail
  def test_duplicate_politic_value
    politic_obj = Politic.new(:name => 'Whig')
    assert !politic_obj.valid?
    assert politic_obj.errors.invalid?(:name)
  end
  
  # Check that update is possible
  def test_politic_only_update
    politic_obj = Politic.find_by_name(politics(:parliamentarian).name)
    politic_obj.grouping = "Pittite"
    politic_obj.name = "Anti-Jacobin"
    assert politic_obj.save
  end
  
  # Confirm grouping not needed on record modification
  def test_grouping_and_politic_valid
    politic_obj = Politic.find_by_id(politics(:whig).id)
    politic_obj.grouping = ""
    assert politic_obj.save
  end
  
  # Confirm a new record will save
  def test_new_record_saves
    politic_obj = Politic.new(:name => "Cromwellian, \"Godly Rule\"")
    assert politic_obj.save
  end
  
  def test_metaphors
    p = politics(:whig)
    assert_equal Array, p.metaphors.class
    assert_equal 1, p.metaphors.size
  end
  
end