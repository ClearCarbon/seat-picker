SeatPicker::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'home#index'

  resources :picker, only: [:index] do
    member do
      post :pick
      post :make_request
      post :cancel_request
    end
    collection do 
      post :give_up
      post :donate_seat
      get  :donate_seat
    end
  end
  resources :seats
end
