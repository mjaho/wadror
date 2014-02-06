require 'spec_helper'

describe "Ratings page" do
  before :each do
    user = FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
    brewery = FactoryGirl.create(:brewery)
    beer = FactoryGirl.create(:beer, name:"iso 3", brewery:brewery)
    FactoryGirl.create(:rating, beer:beer, user:user)
    FactoryGirl.create(:rating2, beer:beer, user:user)
  end

    it "shows the number of ratings in the database" do
      visit ratings_path
      expect(page).to have_content 'Number of ratings: 2'
    end

    it "lists all of the created ratings" do
      visit ratings_path
      expect(page).to have_content 'iso 3 anonymous 10'
      expect(page).to have_content 'iso 3 anonymous 20'
    end
end