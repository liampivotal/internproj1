class AddWinnerIdAndStatusToElections < ActiveRecord::Migration
  def change
    add_column :elections, :status, :string
    add_column :elections, :winner_id, :integer
  end
end
