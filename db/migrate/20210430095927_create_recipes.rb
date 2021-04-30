class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :url_video
      t.string :url_image
      t.integer :preparation_time
      t.integer :cooking_time
      t.boolean :favorite, default: false
      t.text :note
      t.boolean :note_private, default: false
      t.boolean :official, default: false
      t.integer :alert
      t.boolean :show, default: true
      t.references :user, null: false, foreign_key: true
      t.integer :recipe_group_id

      t.timestamps
    end
    add_index :recipes, :url_video
    add_index :recipes, :favorite
    add_index :recipes, :official
    add_index :recipes, :show
    add_index :recipes, :recipe_group_id
  end
end
