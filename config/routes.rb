Lvlapp::Application.routes.draw do

  get "memorize/show"
  get "memorize/index"
  get "memorize/create"
  get "memorize/update"
  get "memorize/random"

  devise_for :users, :controllers => {:registrations => "registrations"}

  get 'admin/help' => 'admin/help#index'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :audio_videos do
    resources :phrases
    resources :game_data, only: [:create]
  end

  resources :phrases do
    collection do
      post :sm2_update
    end
  end

  resources :game_data, only: [:index, :create]

  root :to => 'home#index'
  get '/about' => 'home#about'

  get 'ted_transcript/' => 'admin/ted_transcripts#new'
  post 'ted_transcript/create' => 'admin/ted_transcripts#create'

  get 'shift_transcript/' => 'admin/audio_video_lrc#shift'
  get 'lrc/new' => 'admin/audio_video_lrc#new'
  post 'lrc/create' => 'admin/audio_video_lrc#create'
  get 'youtube_parser/new' => 'admin/youtube_parser#new'
  post 'youtube_parser/create' => 'admin/youtube_parser#create'
  get 'srt/new' => 'admin/srt#new'
  post 'srt/create' => 'admin/srt#create'
  get 'text_lyrics/new' => 'admin/text_lyrics#new'
  post 'text_lyrics/create' => 'admin/text_lyrics#create'
end
