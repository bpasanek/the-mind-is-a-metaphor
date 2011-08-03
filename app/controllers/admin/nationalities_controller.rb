class Admin::NationalitiesController < AdminController
  
  resource_controller
  belongs_to :author
  
  include Searchable

end
