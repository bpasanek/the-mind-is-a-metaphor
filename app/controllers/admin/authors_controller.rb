class Admin::AuthorsController < AdminController
  
  resource_controller
  belongs_to :work
  
  include Searchable
  
end