class ElectionFields < ActiveRecord::Migration
  def change
    add_column :elections, :title, :string
  end
end
