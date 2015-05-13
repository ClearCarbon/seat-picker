SeatPicker::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  authenticated :user do
    root to: 'picker#index', as: :user_root
  end

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
    end
  end

  resources :users, only: [:destroy] do
    get :cancel_account, on: :collection
  end

  namespace :admin do
    resources :users do
      member do
        post :promote_to_admin
        post :demote_from_admin
      end
    end
    
    resources :seats
  end
end
