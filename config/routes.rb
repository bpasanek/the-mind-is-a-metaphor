TheMindIsAMetaphor::Application.routes.draw do
  match 'admin' => 'admin/metaphors#index', :as => :admin
  namespace :admin do
      resources :classifications
      resources :metaphors do
      
        resources :works
        resources :classifications
        resources :types
      end
      
      resources :works do
    
    
          resources :authors
      resources :classifications
      resources :metaphors
    end
      resources :authors do
    
    
          resources :works
      resources :occupations
      resources :religions
      resources :politics
      resources :nationalities
      resources :metaphors
    end
      resources :types
      resources :religions
      resources :politics
      resources :occupations
      resources :nationalities
  end

  match '/simple_captcha/:action' => 'simple_captcha#index', :as => :simple_captcha
  resources :contact, :only => [:index, :create] do
    collection do
  get :thank_you
  end
  
  
  end

  resources :metaphors, :only => [:index, :show]
  match 'metaphors/item/:offset' => 'metaphors#search_item', :as => :metaphors_search_item
  match '/' => 'metaphors#index'
  match ':id' => 'pages#render_page', :as => :pages
end

