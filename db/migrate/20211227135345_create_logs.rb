class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :status
      t.string :url
      t.string :path
      t.text :user_inspect
      t.bigint :user_id
      t.bigint :group_id
      t.bigint :role_id
      t.string :rank
      t.float :time_spent
      t.string :user_agent
      t.string :ip
      t.string :request_method
      t.string :http_host
      t.string :exception_class
      t.text :exception_message

      t.timestamps
    end
  end
end
