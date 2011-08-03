require 'test_helper'

class NationalityTest < ActiveSupport::TestCase
  fixtures :nationalities
  
  # Don't allow a completely empty record
  def test_no_nationality_fails
    empty = Nationality.new
    assert !empty.valid?
    assert empty.errors.invalid?(:name)
  end
  
  # Make sure that the nationality doesn't contain invalid characters
  def test_invalid_nationality_value
    nationality_obj = Nationality.new(:name => 'American > United States')
    assert !nationality_obj.valid?
    assert nationality_obj.errors.invalid?(:name)
  end
  
  # Nationality must be unique - second occurrence of american should fail
  def test_duplicate_nationality_value
    nationality_obj = Nationality.new(:name => 'american')
    assert !nationality_obj.valid?
    assert nationality_obj.errors.invalid?(:name)
  end
  
  # Check that update is possible
  def test_nationality_only_update
    nationality_obj = Nationality.find_by_name(nationalities(:american).name)
    nationality_obj.name = "Russian"
    assert nationality_obj.save
  end
  
  # Confirm a new record will save
  def test_new_record_saves
    nationality_obj = Nationality.new(:name => "German")
    assert nationality_obj.save
  end
  
  def test_metaphors
    n = nationalities(:english)
    assert_equal Array, n.metaphors.class
    assert_equal 6, n.metaphors.size
  end
  
end