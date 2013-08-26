MishDinners::Application.routes.draw do
  root 'calendars#index'

  resource :calendars, :only => [:index, :show]

  get ':division_abbr/:unit_abbr' => 'calendars#show'
end
