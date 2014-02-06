require 'spec_helper'

describe "User page" do

    let!(:user) { FactoryGirl.create :user }
    let!(:otheruser) { FactoryGirl.create :user, username:'otheruser' }
    let!(:beer) { FactoryGirl.create :beer, name:"iso 3" }
    let!(:beer2) { FactoryGirl.create :beer, name:"karhu" }
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


end