class CreateRecipeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_groups do |t|
      t.string :name
      t.boolean :private, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
