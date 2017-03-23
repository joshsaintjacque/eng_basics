class AddGeneratedFibsToFib < ActiveRecord::Migration[5.0]
  def change
    add_column :fibs, :generated_fibs, :text
  end
end
