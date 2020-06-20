# frozen_string_literal: true

require 'constraints/subdomain_required'

Twist::Application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  constraints(SubdomainRequired) do
    scope module: 'accounts' do
      root to: 'books#index', as: :account_root

      notes_routes = lambda do
        collection do
          get :completed
        end

        member do
          put :accept
          put :reject
          put :reopen
        end

        resources :comments
      end

      resources :books do
        member do
          post :receive
        end

        resources :chapters do
          resources :elements do
            resources :notes
          end

          resources :notes, &notes_routes
        end

        resources :notes, &notes_routes
      end
    end
  end

  root to: 'home#index'

  get '/accounts/new', to: 'accounts#new', as: :new_account
  post '/accounts', to: 'accounts#create', as: :accounts
  get 'signed_out', to: 'users#signed_out'
end
