require 'test_helper'

class MetaphorTest < ActiveSupport::TestCase
  # Test that the metaphor exists
  def test_empty_metaphor
    met = Metaphor.new(:metaphor => "")
    assert !met.valid?
    assert met.errors.invalid?(:metaphor)
  end
  
  # Test that duplicate metaphors are not allowed
  def test_invalid_duplicate_metaphor
    met = Metaphor.new(:metaphor => " None can chain a mind / Whom this sweet chordage cannot bind.")
    assert !met.save
  end
  
  # Test date fields
  def test_date_fields
    met = Metaphor.new(:metaphor => "This is a new metaphor")
    currentTime = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S %Z")
    met.save
    #puts met.created_at.to_s
    assert (met.created_at.to_s == currentTime)
    # Make a second go by before saving changes so updated_at is different
    for i in 0...100000
      met.dictionary = "Dictionary term" + i.to_s
    end
    currentTime = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S %Z")
    met.save
    assert (met.updated_at.to_s == currentTime)
    #puts met.updated_at.to_s
    assert (met.created_at.to_s != currentTime)
  end
  
end
