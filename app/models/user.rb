class User < ActiveRecord::Base
  include RatingAverage
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships, :uniq => true
  has_many :ratings, dependent: :destroy
  has_secure_password


  validates :username, uniqueness: true
  validates :username, length: { minimum: 3,
                                 maximum: 15 }
  #validates :password, length: { minimum: 4 }
  validates :password, presence: {on: :create}, format: {with: /\A((?=.*\d)(?=.*[A-Z])).{4,}/, message: "has to contain at least one number and one upper case character"}
end
