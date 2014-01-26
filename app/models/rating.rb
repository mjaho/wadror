class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    "#{beer.to_s} #{self.score}"
  end

end
