class Notification < ApplicationRecord
  scope :unseen, -> { where(seen: false) }
  after_commit :update_global_notifications_stream

  private

    def update_global_notifications_stream
      Turbo::StreamsChannel.broadcast_replace_to(:global_notifications_stream,
          target: "title-notifications",
          partial: "shared/page_title"
        )
    end
end
