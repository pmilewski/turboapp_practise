module MessagesHelper
  def voted_messages_hash
    @voted_messages_hash ||= current_user.votes.where(votable_type: "Message", vote_scope: "like").pluck(:votable_id, :vote_flag).to_h
  end

  def bookmarked_messages_ids
    @bookmarked_messages_ids ||= current_user.votes.where(votable_type: "Message", vote_scope: "bookmark").pluck(:votable_id)
  end

  def upvote_button(message)
    if voted_messages_hash[message.id]
      button_action = "Unvote"
      class_name = "upvoted w-32"
    else
      button_action = "Upvote"
      class_name = "w-32"
    end

    button_to "#{message.cached_scoped_like_votes_up} #{button_action}", upvote_message_path(message), method: :patch, class: class_name
  end

  def downvote_button(message)
    if voted_messages_hash[message.id] == false
      button_action = "Unvote"
      class_name = "downvoted w-32"
    else
      button_action = "Downvote"
      class_name = "w-32"
    end

    button_to "#{message.cached_scoped_like_votes_down} #{button_action}", downvote_message_path(message), method: :patch, class: class_name
  end

  def bookmark_button(message)
    if bookmarked_messages_ids.include?(message.id)
      button_action = "Unbookmark"
      class_name = "bookmarked w-32"
    else
      button_action = "Bookmark"
      class_name = "w-32"
    end

    button_to button_action, bookmark_message_path(message), method: :patch, class: class_name
  end
end
