Rails.application.routes.draw do
  resources :records
  resources :logs
  resources :rolestorules
  resources :rules
  resources :roles
  resources :dialstogroups
  resources :dialstousers
  resources :dials
  resources :groups
  resources :cdrs
  resources :users
#  resource :record
  
  # hardcode way for like this form in view:
  # <%= form_with url: "/mass_update", method: :post do |form| %>
  # <% end %>
    
  # Great way for dynamic routes for collection:
  
  resources :dials do
    collection do
      post :common_report
      get :common_report
    end
  end  
  
   resources :dials do
    member do
      post :mass_update,  :record_sound, :make_calls
      get  :basic_report , :unpined_report
    end
  end  
    
   resources :roles do
    member do
      post :mass_update
    end
  end  

  resources :users do
    collection do
      post :search
    end
  end

   resources :dials do
    collection do
      post :search
    end
  end

   resources :records do
    member do
      post :record_sound, :play_sound
    end
  end

  resource :auth, only: %i[show create destroy], controller: :auth
  resource :auth_verifications, only: %i[show create]
  
  Rails.application.routes.draw do
    #resources :records
    match '*unmatched', to: 'application#route_not_found', via: :all
  end
  
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
