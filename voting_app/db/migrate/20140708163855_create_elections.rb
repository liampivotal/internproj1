class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.integer :owner
      t.timestamps
    end
  end
end
