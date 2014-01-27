include ActionView::Helpers::TextHelper
include RatingAverage

class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: true

  def to_s
    "#{self.name} #{self.brewery.name}"
  end
end
