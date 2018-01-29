Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :locations do
        resources :recordings
      end
    end

    namespace :v2 do
      mount Api::V2::Locations, at: "/locations"
    end
  end

  resources :locations
end
