module RatingAverage

  include ActionView::Helpers::TextHelper

  def average_rating
    #total=(ratings).inject(0) { |sum, rating| sum+rating.score }
    #amount=ratings.count
    #"Has " + pluralize(amount, 'rating', 'ratings') + ", average " + total/amount
    "Has " + pluralize(ratings.count, 'rating', 'ratings') + ", average #{ratings.average('score')}"
  end

end