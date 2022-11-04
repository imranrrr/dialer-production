class CreateDialsToGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :dialstogroups do |t|
      t.belongs_to :group
      t.belongs_to :dial
      t.boolean :dialed, :default => false, index: true
      t.timestamps
      t.index [:group_id, :dial_id], unique: true
    end
  end
end
