# Politic identifies the political affiliation of an author.
#
# =Relationships
# * has Author(s)
#
# =Validation
# * +name+ is required and must be unique
class Politic < ActiveRecord::Base
  
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
  
  # Validate the religion text coming in from a form such that < and > are not
  # allowed to prevent cross site scripting.
  validates_each :name, :allow_nil=>false do |model, attr, value|
    if (value =~ /<|>/)
      model.errors.add(attr, "greater or less than character not allowed")
    end
  end
  
  # The grouping field is optional so allow it to be empty; but when not, make sure
  # < and > are not allowed in the text entered to prevent cross site scripting.
  validates_each :grouping, :allow_nil=>true do |model, attr, value|
    if (value =~ /<|>/)
      model.errors.add(attr, "greater or less than character not allowed")
    end
  end
  
  # class-level ordered list
  def self.all_ordered
    @all_ordered ||= find(:all, :order => 'grouping ASC, name ASC')
  end
  
  # This is so SolrObserver can easily call #metaphors on each object it's observing.
  def metaphors
    self.authors.map{|a|a.metaphors}.flatten.uniq
  end
  
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
end