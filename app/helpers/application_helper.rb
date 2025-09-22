module ApplicationHelper
  include Pagy::Frontend

  def new_notifications_count
    @new_notifications_count ||= Notification.unseen.count
  end
end
