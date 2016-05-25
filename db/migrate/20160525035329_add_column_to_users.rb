class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :qq, :string
    add_column :users, :address, :string
  end
end
