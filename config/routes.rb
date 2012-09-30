TextileEditorExamples::Application.routes.draw do

  resources :user_sessions
  resources :users

  match 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', as: :logout

  resources :posts

  root to: 'posts#index'

end
