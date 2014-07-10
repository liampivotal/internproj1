class RemoveUserFromElections < ActiveRecord::Migration
  def change
    remove_column :elections, :user
  end
end
