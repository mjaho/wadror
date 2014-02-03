require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved with a password that is too short" do
    user = User.create username:"Pekka", password:"asd", password_confirmation:"asd"

    expect(user.valid?).to be(false)
    expect(User.count).to eq (0)
  end

  it "is not saved with a password that consists of letters only" do
    user = User.create username:"Pekka", password:"asdASDASd", password_confirmation:"asdASDASd"

    expect(user.valid?).to be(false)
    expect(User.count).to eq (0)
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "Favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has the method for determining one" do
      user.should respond_to :favorite_style
    end

    #it "has the correct one" do
    #create_beers_with_ratings
    #end

  end

  describe "Favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has the method for determining one" do
      user.should respond_to :favorite_brewery
    end

  end

  describe "Favorite beer" do
    let(:user){FactoryGirl.create(:user)}

      it "has method for determining one" do
        user.should respond_to :favorite_beer
      end

      it "without ratings does not have one" do
        expect(user.favorite_beer).to eq(nil)
      end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      #beer1 = FactoryGirl.create(:beer)
      #beer2 = FactoryGirl.create(:beer)
      #beer3 = FactoryGirl.create(:beer)
      #rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      #rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
      #rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)
      #create_beer_with_rating(10, user)
      #best = create_beer_with_rating(25, user)
      #create_beer_with_rating(7, user)

      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end

  end

  describe "with a proper password" do
    #let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "with a proper password and two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beer_with_rating_and_style
  end

  def create_beers_with_ratings_and_styles
  end

end
