class Message < ApplicationRecord
  acts_as_votable
  validates :body, presence: true

  def bookmark!(user)
    if user.voted_up_on? self, vote_scope: "bookmark"
      self.unvote_by user, vote_scope: "bookmark"
    else
      self.upvote_by user, vote_scope: "bookmark"
    end
  end

  def upvote!(user)
    if user.voted_up_on? self, vote_scope: "like"
      self.unvote_by user, vote_scope: "like"
    else
      self.upvote_by user, vote_scope: "like"
    end
  end

  def downvote!(user)
    if user.voted_down_on? self, vote_scope: "like"
      self.unvote_by user, vote_scope: "like"
    else
      self.downvote_by user, vote_scope: "like"
    end
  end
end
