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

  def favorite_beer
    return nil if ratings.empty?
    #ratings.sort_by{ |r| r.score }.last.beer
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    style_ratings = ratings.group_by { |rating| rating.beer.style }
    style_ratings = style_ratings.each_pair{|style, score| style_ratings[style] = score.sum(&:score) / score.size}
    return style_ratings.sort_by{ |style, score| score}.last[0]
  end

  def favorite_brewery
  end

end
