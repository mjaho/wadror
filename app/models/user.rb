class User < ActiveRecord::Base
  include RatingAverage
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
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
    beer_ratings_by_style = ratings.group_by { |r| r.beer.style }
    find_highest_average(beer_ratings_by_style)
  end

  def favorite_brewery
    return nil if ratings.empty?
    beer_ratings_by_brewery = ratings.group_by { |r| r.beer.brewery }
    find_highest_average(beer_ratings_by_brewery)
  end

  def find_highest_average(ratings)
    fav = nil
    highest = -1

    ratings.each do |r|
      avg = r[1].inject(0){ | sum, rating | sum + rating.score } / r[1].length.to_f
      if avg > highest
        fav = r[0]
        highest = avg
      end
    end

    return fav
  end

end
