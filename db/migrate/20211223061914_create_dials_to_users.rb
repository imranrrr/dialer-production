class CreateDialsToUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :dialstousers do |t|
      t.belongs_to :user
      t.belongs_to :dial
      t.boolean :dialed, :default => false, index: true
      t.timestamps
      t.index [:user_id, :dial_id], unique: true
    end
  end
end
