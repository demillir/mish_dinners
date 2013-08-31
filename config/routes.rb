MishDinners::Application.routes.draw do
  root 'pages#home'

  resources :calendars, :only => [:show, :edit, :update]
  resources :settings,  :only => [:edit, :update]

  get ':division_abbr/:unit_abbr/:uuid' => 'calendars#edit'
  get ':division_abbr/:unit_abbr'       => 'calendars#show'
end
