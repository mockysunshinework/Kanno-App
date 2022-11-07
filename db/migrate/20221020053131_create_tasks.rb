class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :status, default: "未"
      t.date :deadline
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
