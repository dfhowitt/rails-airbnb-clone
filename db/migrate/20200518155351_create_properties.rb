class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :property_type
      t.string :location
      t.string :name
      t.text :description
      t.float :price
      t.integer :capacity
      t.boolean :availability, default: true

      t.timestamps
    end
  end
end
