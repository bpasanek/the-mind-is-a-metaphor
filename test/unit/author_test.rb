require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors

  # test that name is unique and not empty
  # NOTE: At some point this would be invalid once clean up has been performed 
  # and last_name and first_name are in use instead
  def test_no_name_fails
    empty = Author.new
    assert !empty.valid?
    assert empty.errors.invalid?(:name)
  end
  
  # Test that name is the only required field for an author;
  # confirm that the gender defaults to male
  def test_name_only_and_default_gender
    person = Author.new(:name => 'Thomson, James')
    assert person.save
    assert person.gender == 'Male'
  end
  
  # make sure that the gender field only allows male, female, and unknown
  def test_valid_gender_value
    person = Author.new(:name => 'Pope, Alexander (1688-1744)')
    Author.genders.each do |value|
      person.gender = value
      assert person.valid?, person.errors.full_messages
    end
  end
  
  # confirm that a politic relationship exists
  def test_politic_relationship
    person = Author.find_by_name(authors(:first).name)
    assert person.politic
  end
  
  # test that a religion relationship does or does not have to exist
  def test_religion_relationship
    person = Author.find_by_id(authors(:first).id)
    assert person.religion
    person = Author.find_by_id(authors(:second).id)
    assert !person.religion
  end
  
  # confirm that the occupation relationship exists
  def test_occupation_relationship
    person = Author.find_by_id(authors(:first).id)
    assert person.occupation
  end
  
  # confirm that the nationality relationship exists
  def test_nationality_relationship
    person = Author.find_by_name(authors(:second).name)
    assert person.nationality
  end
  
  # confirm the update of an existing record
  def test_author_update
    person = Author.find_by_id(authors(:second).id)
    person.occupation = Occupation.find_by_name('Writer')
    assert person.save
  end
  
  # confirm saving a new record
  def test_new_author_save
    person = Author.new(:name => 'Donne, John', :date_of_birth => '1572', :date_of_death => '1631')
    person.nationality = Nationality.find_by_name('English')
    assert person.save
  end
  
  # test the author works relationship
  def test_author_works
    person = Author.find_by_id(authors(:third).id)
    assert person.author_works.empty?
    assert person.author_works
    person = Author.find_by_id(authors(:first).id)
    assert ! person.author_works.empty?
  end
  
  # test the work relationship
  def test_works
    person = Author.find_by_id(authors(:third).id)
    assert person.works.empty?
    assert person.works
    person = Author.find_by_id(authors(:second).id)
    assert ! person.works.empty?
  end
  
  def test_metaphors
    a = authors(:first)
    assert_equal Array, a.metaphors.class
    assert_equal 5, a.metaphors.size
  end
  
  test 'that the search method returns all records when the q param is blank' do
    result = Author.search(:q=>'')
    assert_equal 3, result.size
  end
  
  test 'that the search method does what it says it does when using the q param' do
    result = Author.search(:q=>'Marvell')
    assert_equal 1, result.size
    assert_equal 'Marvell, Andrew', result.first.name
  end
  
end