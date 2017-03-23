class AddGenerateToFib < ActiveRecord::Migration[5.0]
  def change
    add_column :fibs, :generate, :integer
  end
end
