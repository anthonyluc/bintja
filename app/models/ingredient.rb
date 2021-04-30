class Ingredient < ApplicationRecord
    has_many :quantities, dependent: :delete_all
    has_many :recipes, through: :quantities
  
    validates :name, presence: true, uniqueness: true
  
    accepts_nested_attributes_for :quantities  
end