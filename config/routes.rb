Lvlapp::Application.routes.draw do

  devise_for :users

  get 'admin/help' => 'admin/help#index'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :audio_videos do
    resources :phrases
    resources :game_data, only: [:create]
  end
  resources :phrases

  resources :game_data, only: [:index, :create]

  root :to => 'home#index'

  get 'ted_transcript/' => 'admin/ted_transcripts#new'
  post 'ted_transcript/create' => 'admin/ted_transcripts#create'

  get 'shift_transcript/' => 'admin/audio_video_lrc#shift'
  get 'lrc/new' => 'admin/audio_video_lrc#new'
  post 'lrc/create' => 'admin/audio_video_lrc#create'
  get 'srt/new' => 'admin/srt#new'
  post 'srt/create' => 'admin/srt#create'
end
