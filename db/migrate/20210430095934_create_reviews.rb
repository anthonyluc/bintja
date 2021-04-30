class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :comment
      t.string :video_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reviews, :stars
  end
end
