class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [ :dashboard ]

  def landing_page
    online_users = Kredis.unique_list "online_users"
    @online_users = User.find(online_users.elements)
  end

  def dashboard
  end
end
