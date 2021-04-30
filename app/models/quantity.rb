class Quantity < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :quantity, presence: true
  validates :unity, presence: true

  accepts_nested_attributes_for :ingredient
end