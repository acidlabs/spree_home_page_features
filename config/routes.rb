Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :banners do
      collection do
        post :update_positions
      end
    end
    resources :banner_categories
  end
end
