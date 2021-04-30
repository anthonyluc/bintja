class CreateShoppingLists < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_lists do |t|
      t.text :shopping_note
      t.boolean :receive_email, default: true
      t.string :receive_email_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :shopping_lists, :receive_email
    add_index :shopping_lists, :receive_email_day
  end
end
