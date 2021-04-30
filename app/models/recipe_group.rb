class RecipeGroup < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :user
  
  validates :name, presence: true
end
