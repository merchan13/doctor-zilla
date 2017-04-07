Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated do
      root to: 'pages#index'
    end
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  get '/:page/home', to: 'pages#home', as: 'option'
  resources :medical_records

end
