class CreateResourceUpdates < ActiveRecord::Migration
  def change
    create_table :resource_updates do |t|
      t.string :name
      t.datetime :updated
      t.text :source_uri
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :resource_updates, :name
    add_foreign_key :resource_updates, :users
  end
end
