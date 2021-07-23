Rails.application.routes.draw do
  resource :links, only: [ :create, :index ]
  get '/s/:slug', to: 'links#show', as: :short
end
