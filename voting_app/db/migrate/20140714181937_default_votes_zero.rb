class DefaultVotesZero < ActiveRecord::Migration
  def change
    remove_column :choices, :votes
    add_column :choices, :votes, :integer, default: 0
  end
end
