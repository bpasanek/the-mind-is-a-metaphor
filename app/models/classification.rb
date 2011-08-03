class Classification < ActiveRecord::Base
  
  belongs_to :classifiable, :polymorphic => true
  
  def self.find_all_with_prefix(prefix, limit=5)
    matches = {}
    self.find(:all, :conditions=>['classifications.value LIKE ?', "#{prefix}%"], :limit=>limit).each do |c|
      matches[c.value] = c
    end
    matches.values
  end
  
  # splits the value on a ::
  # returns an array
  def values
    self.value.split('::') if self.value =~ /::/
  end
  
  # This is so SolrObserver can easily call #metaphors on each object it's observing.
  def metaphors
    case self.classifiable
    when Work
      self.classifiable.metaphors
    when Metaphor
      [self.classifiable]
    else
      []
    end
  end
  
end