class CreateCodeFreezes < ActiveRecord::Migration
  def change
    create_table :code_freezes do |t|
      t.string :version, limit: 100
      t.string :date, limit: 26

      t.timestamps null: false
    end
    add_index :code_freezes, :version
  end
end
