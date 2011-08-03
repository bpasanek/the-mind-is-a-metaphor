class Admin::MetaphorsController < AdminController
  
  resource_controller
  belongs_to :type, :work, :author
  
  include Searchable

end