Rails.application.routes.draw do
  resource :links, only: [ :create, :index ]
end
