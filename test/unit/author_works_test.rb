require 'test_helper'

class AuthorWorkTest < ActiveSupport::TestCase
  # See if authors exist
  def test_authors_exist
    publication = AuthorWork.find_by_id(author_works(:publication1).id)
    assert publication.author
  end
  
  # See if works exist
  def test_works_exist
    publication = AuthorWork.find_by_id(author_works(:publication3).id)
    assert publication.work    
  end
  
end