class Post < ApplicationRecord
  enum :access, [ :draft, :published, :passcode_protected ]

  validates_presence_of :title, :body, :access
  validates :passcode, presence: true, if: -> { passcode_required? }

  def passcode_required?
    access == "passcode_protected"
  end
end
