class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    # 以下を追加
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :department, :string
    add_column :users, :partner, :boolean, default: true
    add_column :users, :admin, :boolean, default: false
  end
end
