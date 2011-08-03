ActionController::Routing::Routes.draw do |map|
  
  # this is a dummy route, apache will intercept the request and forward to a WordPress instance
  #map.blog '/blog'
  
  map.admin 'admin', :controller=>'admin/metaphors', :action=>'index'
  
  map.namespace :admin do |admin|
    
    admin.resources :classifications
    
    admin.resources :metaphors do |m|
      m.resources :works
      m.resources :classifications, :as => :categories
      m.resources :types
    end
  
    admin.resources :works do |w|
      w.resources :authors
      w.resources :classifications, :as => :genres
      w.resources :metaphors
    end
    
    admin.resources :authors do |a|
      a.resources :works
      a.resources :occupations
      a.resources :religions
      a.resources :politics
      a.resources :nationalities
      a.resources :metaphors
 #     a.resources :author_works
    end
    
    admin.resources :types
    
    admin.resources :religions
  
    admin.resources :politics
  
    admin.resources :occupations
  
    admin.resources :nationalities
  end
  
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  
  map.resources :contact, :only => [:index, :create], :collection => {:thank_you => :get}
  
  map.resources :metaphors, :only => [:index, :show]
  
  #
  map.metaphors_search_item 'metaphors/item/:offset', :controller=>'metaphors', :action=>'search_item'
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'metaphors', :action=>'index'
  
  map.pages ':id', :controller=>'pages', :action=>'render_page'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end