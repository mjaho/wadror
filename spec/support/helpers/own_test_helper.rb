module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_rating(score, user)
    style = FactoryGirl.create(:style)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beer_with_rating_and_style(score, style, user)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score, user:user, beer:beer)
    beer
  end

  def create_beers_with_ratings_and_style(*scores, user, style)
    s1 = FactoryGirl.create(:style, style: style)
    scores.each do |score|
      create_beer_with_rating_and_style(score, s1, user)
    end
  end

  def create_beer_with_rating_and_brewery(score, brewery, user)
    s1 = FactoryGirl.create(:style)
    beer = FactoryGirl.create(:beer, style: s1, brewery:brewery)
    FactoryGirl.create(:rating, score:score, user:user, beer:beer)
    beer
  end

  def create_beers_with_ratings_and_brewery(*scores, user, brewery)
    scores.each do |score|
      create_beer_with_rating_and_brewery(score, brewery, user)
    end
  end
end
