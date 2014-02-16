include ActionView::Helpers::TextHelper
include RatingAverage

class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style


  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{self.name} #{self.brewery.name}"
  end
end
