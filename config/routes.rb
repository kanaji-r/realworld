Rails.application.routes.draw do
  namespace :api do
    resources :articles, param: :slug
  end
end
