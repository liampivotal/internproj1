class AddVotedBooleanToElectionUsers < ActiveRecord::Migration
  def change
    add_column :elections_users, :voted, :boolean, default: false
  end
end
