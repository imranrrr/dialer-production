class CreateCdrs < ActiveRecord::Migration[6.1]
  def change
    create_table :cdrs do |table|
        table.datetime :calldate, null: false, default: 0o000 - 0o0 - 0o0
        table.string :clid, limit: 80, null: false, default: ''
        table.string :src, limit: 80, null: false, default: ''
        table.string :dst, limit: 80, null: false, default: ''
        table.string :dcontext, limit: 80, null: false, default: ''
        table.string :channel, limit: 80, null: false, default: ''
        table.string :dstchannel, limit: 80, null: false, default: ''
        table.string :lastapp, limit: 80, null: false, default: ''
        table.string :lastdata, limit: 256, null: false, default: ''
        table.integer :duration, null: false, default: 0
        table.integer :billsec, null: false, default: 0
        table.datetime :start, null: true, default: nil
        table.datetime :answer, null: true, default: nil
        table.datetime :end, null: true, default: nil
        table.string :disposition, limit: 45, null: false, default: ''
        table.string :amaflags, limit: 80, null: false, default: ''
        table.string :accountcode, limit: 20, null: false, default: ''
        table.string :userfield, limit: 255, null: false, default: ''
        table.string :uniqueid, limit: 40, null: false, default: ''
    end
    add_index :cdrs, :start
    add_index :cdrs, :src
    add_index :cdrs, :dst
    add_index :cdrs, :disposition
    add_index :cdrs, :duration
    add_index :cdrs, :channel
    add_index :cdrs, :dstchannel
    add_index :cdrs, :amaflags
    add_index :cdrs, :accountcode
    add_index :cdrs, :userfield
  end
end
