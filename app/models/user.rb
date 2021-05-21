class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :nickname, presence: true, length: { minimum: 4 }
  validates :email, presence: true, uniqueness: true, format: { with: /(\w[\w\.]+)@(.+)\.(\S+{2,4})/ }

  has_one_attached :avatar
  has_one :shopping_list, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :social_networks, dependent: :destroy
  has_many :reviews
  has_many :recipe_rates, dependent: :destroy
  has_many :quantities, through: :recipes
  has_many :recipe_groups, dependent: :delete_all

  # Initialize social_networks for this new user
  after_create :create_social_networks

  private

  def create_social_networks
    user = User.last
    SocialNetwork.create(user: user)
    ShoppingList.create(user: user)
  end
end