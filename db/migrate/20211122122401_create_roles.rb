class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :role
      t.text :role_description
      t.timestamps
    end
    add_index(:roles, :role, unique: true)
  end
end
