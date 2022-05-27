Rails.application.routes.draw do
  # devise_for :users, :controllers => {
  #                      :registrations => "users/registrations",
  #                      :sessions => "users/sessions",
  #                    }

  # devise_scope :user do
  #   get "user/:id", :to => "users/registrations#detail"
  #   get "signup", :to => "users/registrations#new"
  #   get "login", :to => "users/sessions#new"
  #   get "logout", :to => "users/sessions#destroy"
  # end

  # get "route", to: "route#new"
  # post "route/show", to: "route#show"

  resources :driving do
    collection do
      get :list
    end
  end
  root to: redirect('/driving')
end
