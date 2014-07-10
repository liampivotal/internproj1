class ElectionUsersassociation < ActiveRecord::Migration
  def change
    create_table :elections_users, id: false do |t|
      t.belongs_to :election
      t.belongs_to :user
    end

    add_column :elections, :owner_id, :integer
  end
end
