SeatPicker::Application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :picker, only: [:index] do
    member do
      post :pick
      post :give_up
      post :make_request
    end
  end
  resources :seats
end
