require 'test_helper'

class ClassificationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  def test_metaphor_category_metaphors
    c = classifications(:Metaphor_9681)
    assert_equal Array, c.metaphors.class
    assert_equal 1, c.metaphors.size
  end
  
  def test_work_genres_metaphors
    c = classifications(:Work_4784)
    assert_equal Array, c.metaphors.class
    assert_equal 0, c.metaphors.size
  end
  
end