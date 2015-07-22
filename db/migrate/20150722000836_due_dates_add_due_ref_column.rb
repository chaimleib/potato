class DueDatesAddDueRefColumn < ActiveRecord::Migration
  def change
    add_column :due_dates, :due_ref_id, :integer, references: :due_dates, index: true
  end
end
