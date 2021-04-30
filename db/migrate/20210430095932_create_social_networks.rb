class CreateSocialNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :social_networks do |t|
      t.string :url_youtube
      t.string :url_instagram
      t.string :url_facebook
      t.string :url_website
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
