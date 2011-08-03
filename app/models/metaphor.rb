# Metaphor represents some text within a larger context that has a special meaning.
#
# =Relationships
# * has a Work
# * has CategoryMetaphor(s)
# * has Category(s)
# * has Type(s)
#
# =Validation
# * +metaphor+ is required and must be unique
class Metaphor < ActiveRecord::Base
#  require 'validates_date_of'
  
  # customize how the date fields  are humanized; uses human_attribute_override plugin
  attr_human_name 'created_at' => 'Date of Entry'
  attr_human_name 'updated_at' => 'Date of Review'
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  belongs_to :work
  
  has_many :categories, :as => :classifiable, :class_name => 'Classification'

  has_many :types
  
  # Allow for nested attributes in this model for the classification model. Allow for deleting 
  # a category/classification and don't accept a value if it is blank. Note: :all_blank does
  # not appear to work.
  accepts_nested_attributes_for :categories, 
                                :allow_destroy => true, 
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  # Allow for types to be entered via the metaphor form
  accepts_nested_attributes_for :types,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
                                
  #------------------------------------------------------------------
  # validation
  #------------------------------------------------------------------
  validates_presence_of :metaphor
  validates_uniqueness_of :metaphor,
                          :case_sensitive => false
    
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
  # This is so SolrObserver can easily call #metaphors on each object it's observing.
  def metaphors
    [self]
  end
  
  # a method that does "fulltext" searching
  def self.search(input)
    # REALLY NEED TO "dup" HERE!
    params = input.dup
    find_params = {}
    find_params[:page] = params[:page]
    query = params.delete :q
    unless query.blank?
      find_params[:conditions] = ["#{self.table_name}.metaphor LIKE ?", "%#{query}%"]
    end
    sort = params.delete :sort
    sort_dir = params.delete :sort_dir
    if ! sort.blank? and self.column_names.include?(sort.to_s)
      sort = "#{self.table_name}.#{sort}" unless sort=~/\./
      find_params[:order] = ["#{sort}", sort_dir].compact.join(' ')
    end
    self.paginate(find_params)
  end
  
end