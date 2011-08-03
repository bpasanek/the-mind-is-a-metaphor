class Admin::AuthorWorksController < AdminController
  
  resource_controller
  belongs_to :author, :work
  
  include Searchable
  
end