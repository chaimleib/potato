class CreateDueDates < ActiveRecord::Migration
  def change
    create_table :due_dates do |t|
      t.string :branch_name
      t.string :target_version
      t.string :due

      t.timestamps null: false
    end
    add_index :due_dates, :branch_name, unique: true
    add_index :due_dates, :target_version
  end
end
