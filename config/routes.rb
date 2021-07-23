Rails.application.routes.draw do
  resources :links, only: [ :create, :index ]
  get '/s/:slug', to: 'links#show', as: :short
end
