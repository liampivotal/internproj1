class AddChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :election_id
      t.integer :votes
      t.string :name
      t.timestamps
    end
  end
end
