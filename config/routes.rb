SeatPicker::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user do
    root to: 'events#index', as: :user_root
  end

  root 'home#index'

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

    resources :events, except: [:new] do
      resources :seats
    end
  end

  resources :events, only: [] do
    resources :seats do
      resources :seat_requests, only: [:new, :create]
      member do
        post :pick
        post :give_up
      end
    end

    resources :seat_requests, only: [:show, :destroy] do
      member do
        post :accept
        post :deny
      end
    end

  end
end
