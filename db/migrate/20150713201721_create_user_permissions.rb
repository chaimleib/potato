class CreateUserPermissions < ActiveRecord::Migration
  def change
    create_table :user_permissions do |t|
      t.references :user, index: {:unique=>true}, foreign_key: true
      t.boolean :is_admin

      t.timestamps null: false
    end
  end
end
