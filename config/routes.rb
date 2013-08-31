MishDinners::Application.routes.draw do
  root 'pages#home'

  resources :calendars, :only => [:show, :edit, :update]
  resources :settings,  :only => [:edit, :update]

  if Rails.env.development?
    get '/rails/info/properties' => "rails/info#properties"
    get '/rails/info/routes'     => "rails/info#routes"
    get '/rails/info'            => "rails/info#index"
  end

  get ':division_abbr/:unit_abbr/:uuid' => 'calendars#edit'
  get ':division_abbr/:unit_abbr/edit'  => 'calendars#edit'
  get ':division_abbr/:unit_abbr'       => 'calendars#show'
end
