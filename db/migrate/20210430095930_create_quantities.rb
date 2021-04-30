class CreateQuantities < ActiveRecord::Migration[6.0]
  def change
    create_table :quantities do |t|
      t.integer :quantity
      t.string :unity
      t.boolean :add_shopping_list, default: false
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
    add_index :quantities, :add_shopping_list
  end
end
