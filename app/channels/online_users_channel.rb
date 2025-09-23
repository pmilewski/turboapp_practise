class OnlineUsersChannel < Turbo::StreamsChannel
  def subscribed
    super
    return unless current_user

    online_users = Kredis.unique_list "online_users"
    online_users << current_user.id

    Turbo::StreamsChannel.broadcast_prepend_to(
      verified_stream_name_from_params,
      target: "online-users-list",
      partial: "users/user",
      locals: { user: current_user }
      )
  end

  def unsubscribed
    return unless current_user

    online_users = Kredis.unique_list "online_users"
    online_users.remove current_user.id

    Turbo::StreamsChannel.broadcast_remove_to(
      verified_stream_name_from_params,
      target: "user_#{current_user.id}"
    )
  end
end
