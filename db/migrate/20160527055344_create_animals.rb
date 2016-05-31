class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|

      t.string :type
      t.string :name
      t.integer :age
      t.timestamps null: false
    end
  end
end
