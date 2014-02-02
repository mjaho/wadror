class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships, :uniq => true
end
