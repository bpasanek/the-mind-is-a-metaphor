# Work represents a title of a written text.
#
# =Relationships
# * has Metaphor(s)
# * has Publication(s)
# * has Author(s)
# * has WorkGenre(s)
# * has Genre(s)
#
# =Validation
# * +title+ is required and but does not need to be unique
# * +year_integer+ must be an integer number if not nil
class Work < ActiveRecord::Base
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  has_many :metaphors
  has_many :author_works
  has_many :authors, :through => :author_works
  
  has_many :genres, :as => :classifiable, :class_name => 'Classification'
  
  # Allow for nested attributes in this model for the classification model. Allow for deleting 
  # a category/classification and don't accept a value if it is blank. Note: :all_blank does
  # not appear to work.
  accepts_nested_attributes_for :genres, 
                                :allow_destroy => true, 
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  accepts_nested_attributes_for :author_works,
                                :allow_destroy => false
  
  #------------------------------------------------------------------
  # validation
  #------------------------------------------------------------------
  
  # Title is not expected to be unique since there are cases where a
  # title may not exist or be known and thus may have value like 
  # "Title Not Known"
  validates_presence_of :title

  validates_numericality_of :year_integer,
                            :only_integer => true,
                            :message => "is not an integer",
                            :allow_nil => true
                            
  # class-level ordered list
  def self.all_ordered
    @all_ordered ||= find(:all, :order => 'title ASC')
  end
  
  
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
end