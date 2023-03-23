Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  post 'dispenser', to: 'dispenser#create'
  scope '/dispenser/:id' do
    put '/open', to: 'dispenser#open'
    put '/close', to: 'dispenser#close'
    get '/spending', to: 'dispenser#spending'
  end
end
