class CreateRolesToRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rolestorules do |t|
      t.belongs_to :role # , null: false
      t.belongs_to :rule #, null: false
      t.timestamps
      t.index [:role_id, :rule_id], unique: true
    end
  end
end
