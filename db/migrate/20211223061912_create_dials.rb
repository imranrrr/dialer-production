class CreateDials < ActiveRecord::Migration[6.1]
  def change
    create_table :dials do |t|
      # t.bigint :user_id, null: false
      t.belongs_to :user
      t.string :sound_url, null: false
      t.boolean :recorded, :default => false
      t.string :description, null: false
      t.boolean :dialed, :default => false, index: true 
      t.timestamps
    end
  end
end
