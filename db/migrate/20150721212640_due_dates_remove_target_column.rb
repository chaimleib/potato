class DueDatesRemoveTargetColumn < ActiveRecord::Migration
  def change
    remove_column :due_dates, :target_version
  end
end
