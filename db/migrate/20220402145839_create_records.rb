class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :sound_url
      t.string :description
      t.boolean :recorded, :default => false, index: true
      t.timestamps
    end
  add_index(:records, :description, unique: true)
  end
end
