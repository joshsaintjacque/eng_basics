class AddNameToFib < ActiveRecord::Migration[5.0]
  def change
    add_column :fibs, :name, :string
  end
end
