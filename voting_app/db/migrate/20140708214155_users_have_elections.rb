class UsersHaveElections < ActiveRecord::Migration
  def change
    remove_column :elections, :owner, :integer
    add_column :elections, :user, :integer
  end
end
