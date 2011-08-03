# Type identifies the metaphor text as a metaphor, simile, personification, etc.
#
# =Relationships
# * has Metaphor(s)
#
# =Validation
# * +name+ is required but does not have to be unique
class Type < ActiveRecord::Base
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  belongs_to :metaphor
  
  #------------------------------------------------------------------
  # validation
  #------------------------------------------------------------------
  validates_presence_of :name
  
  # Validate the nationalitytext coming in from a form such that < and > are not
  # allowed to prevent cross site scripting.
  validates_each :name, :allow_nil=>false do |model, attr, value|
    if (value =~ /<|>/)
      model.errors.add(attr, "greater or less than character not allowed")
    end
  end

  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
  def metaphors
    [self.metaphor]
  end
  
end
