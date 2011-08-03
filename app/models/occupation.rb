# Occupation identifies the occupation of an author.
#
# =Relationships
# * has Author(s)
#
# =Validation
# * +name+ is required and must be unique
class Occupation < ActiveRecord::Base
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  has_many :authors
  
  #------------------------------------------------------------------
  # validation
  #------------------------------------------------------------------

  validates_presence_of :name
  validates_uniqueness_of :name,
                          :case_sensitive => false
  
  # Validate the occupation text coming in from a form such that < and > are not
  # allowed to prevent cross site scripting.
  validates_each :name, :allow_nil=>false do |model, attr, value|
    if (value =~ /<|>/)
      model.errors.add(attr, "greater or less than character not allowed")
    end
  end
  
  # class-level ordered list
  def self.all_ordered
    @all_ordered ||= find(:all, :order => 'name ASC')
  end
  
  # This is so SolrObserver can easily call #metaphors on each object it's observing.
  def metaphors
    self.authors.map{|a|a.metaphors}.flatten.uniq
  end
  
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
end