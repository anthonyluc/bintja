class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, authentication_keys: [:login]

  validates :nickname, presence: true, length: { minimum: 4 }, uniqueness: { case_sensitive: false }
  # only allow letter, number, underscore and punctuation.
  validates_format_of :nickname, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :email, presence: true, uniqueness: true, format: { with: /(\w[\w\.]+)@(.+)\.(\S+{2,4})/ }
  validate :validate_nickname

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


  attr_writer :login

  def login
    @login || self.nickname || self.email
  end

  def validate_nickname
    if User.where(email: nickname).exists?
      errors.add(:nickname, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(nickname) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:nickname) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def to_param
    nickname
  end

  private

  def create_social_networks
    user = User.last
    SocialNetwork.create(user: user)
    ShoppingList.create(user: user)
  end
end