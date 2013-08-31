class PagesController < ApplicationController
  def home
    redirect_to url_for(controller: :calendars, action: :show, division_abbr: 'lo', unit_abbr: 'lo')
  end
end
