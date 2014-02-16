require 'spec_helper'

describe "User page" do

    let!(:user) { FactoryGirl.create :user }
    let!(:otheruser) { FactoryGirl.create :user, username:'otheruser' }
    let!(:style) { FactoryGirl.create :style }
    let!(:beer) { FactoryGirl.create :beer, name:"iso 3", style:style }
    let!(:beer2) { FactoryGirl.create :beer, name:"karhu", style:style }
    let!(:rating) { FactoryGirl.create :rating, user:user, beer:beer }
    let!(:rating2) { FactoryGirl.create :rating, user:user, beer:beer }
    let!(:rating3) { FactoryGirl.create :rating, user:otheruser, beer:beer2 }

    it "rating is destroyed when deleted by the User" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(user)

      expect(user.ratings.count).to eq(2)

      page.first(:link, "delete").click

      expect(user.ratings.count).to eq(1)
    end

    it "does not display other users ratings" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(user)
      expect(page).to have_content "Number of ratings: 2"
      expect(page).not_to have_content 'karhu'
    end

    it "displays users ratings and their count" do
      visit user_path(user)
      expect(page).to have_content "Number of ratings: 2"
    end

    it "displays users favorite style" do
      create_beers_with_ratings_and_style(40, 50, 40, 50, user, "IPA")
      create_beers_with_ratings_and_style(20, 30, 40, 20, user, "Stout")
      visit user_path(user)
      expect(page).to have_content "Favorite style: IPA"
    end

    it "displays users favorite brewery" do
      brewery1 = FactoryGirl.create(:brewery, name:"Lempipanimo")
      brewery2 = FactoryGirl.create(:brewery, name:"Ihankivapanimo")
      create_beers_with_ratings_and_brewery(40, 50, 40, 50, user, brewery1)
      create_beers_with_ratings_and_brewery(20, 30, 40, 20, user, brewery2)
      visit user_path(user)
      expect(page).to have_content "Favorite brewery: Lempipanimo"
    end


end