# Author identifies a person that has published some written prose.
#
# =Relationships
# * belongs to Nationalities
# * belongs to Occupations
# * belongs to Politics
# * belongs to Religions
# * has Publication(s)
# * has Work(s)
#
# =Validation
# * +name+ is required and must be unique
# * +gender+ is required and must be one of the acceptable values
class Author < ActiveRecord::Base
  
  def self.genders
    @genders ||= %w[Male Female Unknown]
  end
  
  #------------------------------------------------------------------
  # relationships
  #------------------------------------------------------------------
  has_many :author_works
  has_many :works, :through => :author_works do
    def metaphors
      proxy_owner.works.map{|w| w.metaphors }.flatten.uniq
    end
  end
  
  belongs_to :occupation
  belongs_to :nationality
  belongs_to :politic
  belongs_to :religion
  
  #------------------------------------------------------------------
  # validation
  #------------------------------------------------------------------
  validates_presence_of :name
  validates_uniqueness_of :name,
                          :case_sensitive => false,
                          :allow_nil => false
                          
  validates_presence_of :gender
  validates_inclusion_of :gender, 
                         :in => self.genders,
                         :message => "should be one of these values: " + self.genders.to_sentence()
                         
  #------------------------------------------------------------------
  # public instance methods
  #------------------------------------------------------------------
  
  # returns the authors name,
  # along with the date_of_birth and date_of_death values:
  # Adams, Jean (1710-1765)
  def name_with_dates
    out = self.name.blank? ? "#{self.last_name}, #{self.first_name}" : self.name
    dates = [self.date_of_birth, self.date_of_death]
    (dates.empty? or dates[0].blank?) ? out : "#{out} (#{dates.join(' - ')})"
  end
  
  # This is so SolrObserver can easily call #metaphors on each object it's observing.
  def metaphors
    works.map{|w| w.metaphors }.flatten.uniq
  end
  
  # a method that does "fulltext" searching
  def self.search(input)
    # REALLY NEED TO "dup" HERE!
    params = input.dup
    find_params = {}
    find_params[:page] = params[:page]
    query = params.delete :q
    unless query.blank?
      find_params[:conditions] = [
        "#{self.table_name}.name LIKE ? OR #{self.table_name}.first_name LIKE ? OR #{self.table_name}.first_name LIKE ?",
        "%#{query}%",
        "%#{query}%",
        "%#{query}%"
      ]
    end
    sort = params.delete(:sort).to_s
    sort_dir = params.delete :sort_dir
    if ! sort.blank? and self.column_names.include?(sort.to_s)
      sort = "#{self.table_name}.#{sort}" unless sort =~ /\./
      find_params[:order] = [sort, sort_dir].compact.join(' ')
    end
    self.paginate(find_params)
  end
  
end