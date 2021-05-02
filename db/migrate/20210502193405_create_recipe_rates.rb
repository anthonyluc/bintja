class CreateRecipeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_rates do |t|
      t.integer :stars, null: false, default: 0
      t.string :video_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recipe_rates, :stars
    add_index :recipe_rates, :video_id
  end
end
