# Relates authors to works so that there can be a 
# many-to-many relationship between them.
#
# =Relationships
# * belongs to Authors
# * belongs to Works
class AuthorWork < ActiveRecord::Base
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  belongs_to :author
  belongs_to :work
  
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
end