class Message < ApplicationRecord
  acts_as_votable
  validates :body, presence: true

  def upvote!(user)
    if user.voted_up_on? self
      self.unvote_by user
    else
      self.upvote_by user
    end
  end

  def downvote!(user)
    if user.voted_down_on? self
      self.unvote_by user
    else
      self.downvote_by user
    end
  end
end
