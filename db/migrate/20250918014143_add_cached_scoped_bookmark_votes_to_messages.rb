class AddCachedScopedBookmarkVotesToMessages < ActiveRecord::Migration[8.0]
  def change
    change_table :messages do |t|
      t.integer :cached_scoped_bookmark_votes_total, default: 0
      t.integer :cached_scoped_bookmark_votes_score, default: 0
      t.integer :cached_scoped_bookmark_votes_up, default: 0
      t.integer :cached_scoped_bookmark_votes_down, default: 0
      t.integer :cached_weighted_bookmark_score, default: 0
      t.integer :cached_weighted_bookmark_total, default: 0
      t.float :cached_weighted_bookmark_average, default: 0.0

      # Uncomment this line to force caching of existing scoped votes
      Message.find_each { |p| p.update_cached_votes("bookmark") }
    end
  end
end
