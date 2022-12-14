class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :request_name
      t.string :request_description
      t.date :request_deadline
      t.string :request_status, default: "未"
      t.integer :partner_number      
      t.boolean :request_change_status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
