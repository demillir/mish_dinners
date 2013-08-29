MishDinners::Application.routes.draw do
  root 'calendars#index'

  resource  :calendars, :only => [:index, :show, :edit, :update]
  resources :settings,  :only => [:edit, :update]

  get ':division_abbr/:unit_abbr/:uuid' => 'calendars#edit'
  get ':division_abbr/:unit_abbr'       => 'calendars#show'
end
