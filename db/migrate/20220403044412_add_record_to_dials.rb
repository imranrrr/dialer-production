class AddRecordToDials < ActiveRecord::Migration[6.1]
  def change
    add_reference :dials, :record, null: true, default: nil, foreign_key: true
  end
end
