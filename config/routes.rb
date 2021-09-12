Rails.application.routes.draw do
  devise_for :users #この分は１番上に
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  
  root 'homes#top'
  get 'home/about' => 'homes#about'
end #end無かったので付けました