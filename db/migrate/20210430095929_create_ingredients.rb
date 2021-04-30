class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :calorie
      t.integer :ingredient_category_id

      t.timestamps
    end
    add_index :ingredients, :ingredient_category_id
  end
end
