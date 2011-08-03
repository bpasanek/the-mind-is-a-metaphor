class Admin::WorksController < AdminController
  
  resource_controller
  belongs_to :author, :metaphor
  
  include Searchable

end
