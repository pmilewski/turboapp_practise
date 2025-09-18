class RemoveCachedVotesFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :cached_votes_total, :integer
    remove_column :messages, :cached_votes_score, :integer
    remove_column :messages, :cached_votes_up, :integer
    remove_column :messages, :cached_votes_down, :integer
    remove_column :messages, :cached_weighted_score, :integer
    remove_column :messages, :cached_weighted_total, :integer
    remove_column :messages, :cached_weighted_average, :float
  end
end
