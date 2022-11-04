class CreateRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rules do |t|
      t.string :rule
      t.text :rule_description
      t.timestamps
    end
    add_index(:rules, :rule, unique: true)
  end
end
