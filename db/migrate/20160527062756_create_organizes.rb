class CreateOrganizes < ActiveRecord::Migration
  def change
    create_table :organizes do |t|

      t.string :name
      t.string :ancestry
      t.timestamps null: false
    end
  end
end
