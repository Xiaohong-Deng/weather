Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post :auth, to: "authentication#create"

      resources :locations do
        resource :recordings
      end
    end
  end

  resources :locations
end
