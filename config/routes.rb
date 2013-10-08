SeatPicker::Application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :picker do
    member do
      post :pick
    end
  end
  resources :seats
end
