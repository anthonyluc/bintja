class RecipeRate < ApplicationRecord
  belongs_to :user

  validates :stars, :inclusion => 0..5
end
