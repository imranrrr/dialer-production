class AddAncestryToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :ancestry, :string
    add_index :groups, :ancestry
  end
end
