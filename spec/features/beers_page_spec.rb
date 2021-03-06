require 'spec_helper'

describe "Beer page" do
  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "new" do
    it "can be created if name is valid" do
      FactoryGirl.create(:brewery)
      FactoryGirl.create(:style)
      visit new_beer_path
      fill_in('beer_name', with:'Testi')
      select('IPA', from:'beer[style_id]')
      select('anonymous', from:'beer[brewery_id]')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)

    end

    it "cannot be created if name is nil and redirects appropriately" do
      visit new_beer_path
      expect{
        click_button('Create Beer')
      }.to change{User.count}.by(0)
      expect(page).to have_content 'Name can\'t be blank'
      expect(current_path).to eq (beers_path)
    end

  end
end