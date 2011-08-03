require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  def test_name_exists
    type = Type.new(:name => "")
    assert !type.valid?
    assert type.errors.invalid?(:name)
  end
  
  # Allow for the same name to be specified in another record
  def test_duplicate_name_allowed
    type = Type.new(:name => "Personification")
    type.metaphor_id = types(:metaphor_9682_type).metaphor_id
    assert type.save
  end
  
  # Make sure invalid characters are not allowed in a name
  def test_invalid_characters_in_name
    type = Type.new(:name => "Do not allow < or > in the name")
    assert !type.valid?
    assert type.errors.invalid?(:name)
  end
  
  def test_metaphors
    t = types(:metaphor_9682_type)
    assert_equal Array, t.metaphors.class
    assert_equal 1, t.metaphors.size
  end
  
end