require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # Make sure the title field is not empty
  def test_no_title_fails
    work = Work.new()
    assert !work.valid?
    assert work.errors.invalid?(:title)
  end
  
  # Valid that only a title field is required.
  def test_only_title_needed
    work = Work.new(:title => "&#91;Title Not Known&#93;")
    assert work.valid?
    assert work.save
  end
  
  def test_year_integer_numeric_or_null
    work = Work.new(:title => "Year integer test", :year_integer => "abcd")
    assert !work.valid?
    assert work.errors.invalid?(:year_integer)
    work.year_integer = nil
    assert work.valid?
    assert work.save
  end
  
  def test_publication_relationship
    work = Work.find_by_id(works(:Work_9999_no_author_or_genre).id)
    assert work.author_works.empty?
    assert work.author_works
    work = Work.find_by_id(works(:Work_3752).id)
    assert ! work.author_works.empty?
  end
  
  def test_author_relationship
    work = Work.find_by_id(works(:Work_9999_no_author_or_genre).id)
    assert work.authors.empty?
    assert work.authors
    work = Work.find_by_id(works(:Work_5303).id)
    assert ! work.authors.empty?
  end
  
  def test_genre_relationship
    work = Work.find_by_title(works(:Work_3233).title)
    assert ! work.genres.empty?
    assert work.genres
    work = Work.find_by_title(works(:Work_3754_no_genre).title)
    assert work.genres.empty?
    assert work.genres
  end
  
  def test_metaphors
    assert_equal Array, works(:Work_9999_no_author_or_genre).metaphors.class
  end
  
end