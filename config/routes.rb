MishDinners::Application.routes.draw do
  root 'calendars#index'

  resource :calendars, :only => [:index, :show, :new, :create]

  get ':division_abbr/:unit_abbr/:uuid' => 'calendars#new'
  get ':division_abbr/:unit_abbr'       => 'calendars#show'
end
