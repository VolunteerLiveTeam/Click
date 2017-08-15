Rails.application.routes.draw do
  root :to => redirect('https://liveteam.org/')

  get '/go/:id', to: 'links#destination', as: 'link_destination'
  resources :links, only: [:show, :new, :create]
end
