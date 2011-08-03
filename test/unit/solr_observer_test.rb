require 'test_helper'

class SolrObserverTest < ActiveSupport::TestCase
  
  test 'SolrObserver::SolrizableMetaphor#to_solr on Metaphor_9681' do
    metaphor = metaphors(:Metaphor_9681)
    metaphor.extend SolrObserver::SolrizableMetaphor
    assert metaphor.respond_to?(:to_solr)
    solr_doc = metaphor.to_solr
    expected = {
      :id => metaphor.id,
      :metaphor => metaphor.metaphor,
      :categories => ['Body'],
      :types => ['Metaphor'],
      :work_notes => 'notes here...',
      :work_title => 'A Dialogue between the Resolved Soul and Created Pleasure [From Miscellaneous Poems]',
      :work_year => '1681',
      :author_politic => ['Parliamentarian'],
      :author_gender => ['Male'],
      :work_year_sort => 1681,
      :author_religion => ['Anglican'],
      :work_citation => nil,
      :author_name => ['Marvell, Andrew'],
      :work_genres => ['Poetry'],
      :work_printer => nil,
      :work_composed => nil,
      :author_occupation => ['Poet', 'Politician'],
      :author_nationality => ['English'],
      :work_place_of_publication => nil
    }
    assert solr_doc.keys.all?{|k| expected.include?(k) }
    expected.each do |k,v|
      assert_equal v, solr_doc[k]
    end
  end
  
  test 'SolrObserver::SolrizableMetaphor#extract_author_field_values on Metaphor_9692' do
    metaphor = metaphors(:Metaphor_9692)
    metaphor.extend SolrObserver::SolrizableMetaphor
    assert_equal ['Poet', 'Politician'], metaphor.extract_author_field_values(:occupation)
    assert_equal ['Parliamentarian'], metaphor.extract_author_field_values(:politic)
  end
  
  test 'SolrObserver::SolrizableMetaphor#extract_author_field_values on Metaphor_8483_and_8484_two_categories' do
    metaphor = metaphors(:Metaphor_8483_and_8484_two_categories)
    metaphor.extend SolrObserver::SolrizableMetaphor
    assert_equal ['English'], metaphor.extract_author_field_values(:nationality)
    assert_equal ['Whig'], metaphor.extract_author_field_values(:politic)
  end
  
end