class CookiesController < ApplicationController
  def index
    if params[:cookies_accepted]
      session[:cookies_accepted] = params[:cookies_accepted] == "true" ? true : false
    end
  end
end
