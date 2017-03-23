class AddSequenceLengthToFib < ActiveRecord::Migration[5.0]
  def change
    add_column :fibs, :sequence_length, :integer
    remove_column :fibs, :generate, :integer
  end
end
