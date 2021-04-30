class Recipe < ApplicationRecord
  belongs_to :user

  has_many :quantities, dependent: :destroy
  has_many :ingredients, through: :quantities
  has_one :recipe_group, through: :user, source: :recipe_groups
  accepts_nested_attributes_for :quantities
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true
  validates :url_video, presence: true, format: { with: /https:\/\/www.youtube.com\/watch\?v=([\w\W]+)/ }
end
