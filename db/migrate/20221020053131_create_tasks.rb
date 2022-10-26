class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :status, default: "未"
      t.datetime :deadline
      t.string :request_name
      t.string :request_description

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
