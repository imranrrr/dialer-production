class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.text :group
      t.text :group_description

      t.timestamps
    end
    add_index(:groups, :group, unique: true)
  end
end
