# See ActiveRecord::Observer
# http://api.rubyonrails.org/classes/ActiveRecord/Observer.html
#
# This class is resposible for watching
# the events of metaphors, and the
# related objects:
#   when an object is created, a new solr doc is created.
#   when an object is updated, the associated solr doc is updated
#   when a metaphor object is deleted, the associated solr doc is deleted
#   when a non-metaphor object is deleted, the associated solr doc is updated
class SolrObserver < ActiveRecord::Observer

  cattr_accessor :indexing
  self.indexing = true

  # mixin for each metaphor instance
  module SolrizableMetaphor

    # field is an attribute on a work.author(s) object.
    # returns an array of values based on the author "field" value.
    # the field values are split on "and" and ","
    # Example:
    # metaphor.work.authors.first.occupation = 'Poet and Politician'
    # ['Poet', 'Politician'] == metaphor.work_author_field_values(:occupation)
    def extract_author_field_values(field)
      return if work.nil? or work.authors.empty?
      names = []
      ids = []
      work.authors.each do |a|
        obj = a.send(field)
        next if obj.nil?
        val = obj.name
        next if val.nil?
        names += val.split(/ and |, /i)
        ids << obj.id
      end
      [names.compact.uniq, ids.compact.uniq]
    end

    # packages up all of the "work" fields into a simple hash for solr
    def works_to_solr
      base = {}
      work = self.work
      base[:work_ids]                   = work ? work.id : nil
      base[:work_genres]                = work ? work.genres.map{|g|g.value.split('::').first} : nil# classifiable
      base[:work_title]                 = work ? work.title : nil
      base[:work_year]                  = work ? work.year : nil
      base[:work_year_sort]             = work ? work.year_integer : nil
      base[:work_literary_period]       = work ? LiteraryPeriods.map(work.year_integer).map{|v|v.first} : nil
      base[:work_printer]               = work ? work.printer : nil
      base[:work_place_of_publication]  = work ? work.place_of_publication : nil
      base[:work_citation]              = work ? work.citation : nil
      base[:work_composed]              = work ? work.composed : nil
      base[:work_notes]                 = work ? work.notes : nil
      base
    end

    # packages up all of the "authors" into a simple hash for solr
    def authors_to_solr
      base = {}
      work = self.work
      base[:author_ids]     = work ? work.authors.map{|a| a.id }.uniq : nil
      base[:author_gender]  = work ? work.authors.map{|a| a.gender}.uniq : nil
      base[:author_name]    = work ? work.authors.map{|a| a.name}.uniq : nil
      # these values get split up on "and" or ","
      base[:author_occupation], base[:author_occupation_ids]    = work ? extract_author_field_values(:occupation) : nil
      base[:author_nationality], base[:author_nationality_ids]  = work ? extract_author_field_values(:nationality) : nil
      base[:author_politic], base[:author_politic_ids]          = work ? extract_author_field_values(:politic) : nil
      base[:author_religion], base[:author_religion_ids]        = work ? extract_author_field_values(:religion) : nil
      base
    end

    # flattens the metaphor object graph for solr consumption
    def to_solr
      base = {
        :id             => self.id,
        :category_ids   => self.categories.map{|c|c.id},
        :types          => self.types.map{|c|c.name}.uniq,
        :type_ids       => self.types.map{|c|c.id}
      }
      base.merge!(works_to_solr)
      base.merge!(authors_to_solr)
    end

  end

  # the objects to observe -- part of ActiveRecord::Observer
  observe [
    :author,
    :classification,
    :metaphor,
    :nationality,
    :occupation,
    :politic,
    :religion,
    :type,
    :work
  ]

  # after any of the observed objects are saved, fetch their associated metaphor objects
  # and create solr docs, post and commit
  # ActiveRecord::Observer
  def after_save(object)
    logger.info "SolrObserver: A #{object.class} was just saved! Updating #{object.metaphors.size} solr documents..."
    update_solr(object)
  end

  # after an object has been destroy, find its associated metaphor(s)
  # if the object is a metaphor, remove the solr document
  # if the object is not a metaphor, find the existing solr document,
  # update (remove the appropriate data), post and commit
  # ActiveRecord::Observer
  def after_destroy(object)
    logger.info "SolrObserver: A #{object.class} was just saved! Updating #{object.metaphors.size} solr documents..."
    if object.is_a?(Metaphor)
      delete_from_solr(object)
    else
      update_solr object
    end
  end

  protected

  # "object" - one of the object types being observered.
  # calls the #metaphors object on the object,
  # loops through each metaphor, calling to_solr for each.
  # returns an array of solr docs
  def create_solr_docs_from_object(object)
    object.metaphors.map do |m|
      unless m.nil?
        m.extend SolrizableMetaphor
        m.to_solr
      end
    end.compact
  end

  # adds the result of create_solr_docs_from_object to solr
  # sends a commit to solr
  def update_solr(object)
    return unless index?
    docs = create_solr_docs_from_object(object)
    logger.info "solr docs: #{docs.inspect}"
    return if docs.empty?
    MIAM.solr.add docs
    MIAM.solr.commit
  end

  # deletes a metaphor from solr
  # "object" == instance of Metaphor
  def delete_from_solr(object)
    return unless index?
    solr.delete_by_query("id:#{object.id}")
    solr.commit
  end

  # boolean flag
  def index?
    Rails.env == 'test' || SolrObserver.indexing
  end

  # shortcut to the main solr connection
  def solr; MIAM.solr end

  # shortcut to the logger
  def logger; Rails.logger end

end
