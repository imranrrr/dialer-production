class CreateUsers < ActiveRecord::Migration[6.1]

  def set_pin_code
    pin_code_length = Rails.configuration.set[:pin_code_length]
    pin_code_length.times.map{rand(10)}.join
  end
  
  def change
    
    create_table :users do |t|
     t.string "phone", null: false
     t.string "phone1", null: false #, :default => nil
     t.string "phone2", null: false #, :default => nil
     t.string "fio", null: false
     t.string "rank", null: false
     t.string "auth_secret", null: false
     t.string "pincode", null: false, :default => set_pin_code
     t.boolean "active", :default => true
     t.belongs_to :group, null: false, :foreign_key => { :on_update => :cascade }
     t.belongs_to :role, null: false, :foreign_key => { :on_update => :cascade }
     t.timestamps
    end
    add_index(:users, :phone, unique: true)
    add_index(:users, :phone1, unique: true)
    add_index(:users, :phone2, unique: true)
    add_index(:users, :active)
  end
end
