Rails.application.routes.draw do
  root 'users#home'
  resources :users do
    collection do
      get :show_users
    end
  end
  resources :roles do
    collection do
        post :hide_roles
        post :update_roles
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
