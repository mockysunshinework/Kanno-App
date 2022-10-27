class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :request_name
      t.string :request_description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
