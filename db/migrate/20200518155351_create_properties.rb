class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.string :location
      t.string :name
      t.text :description
      t.float :price
      t.integer :capacity
      t.boolean :availability

      t.timestamps
    end
  end
end
