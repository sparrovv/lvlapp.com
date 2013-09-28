Lvlapp::Application.routes.draw do
  devise_for :users
  resources :phrases

  get 'admin/help' => 'admin/help#index'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :audio_videos do
    resources :phrases
  end

  root :to => 'home#index'

  get 'ted_transcript/' => 'admin/ted_transcripts#show'
  get 'shift_transcript/' => 'admin/audio_video_lrc#shift'
  get 'lrc/new' => 'admin/audio_video_lrc#new'
  post 'lrc/create' => 'admin/audio_video_lrc#create'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
